import os

import re

import shutil

import subprocess

from sys import exit

from tempfile import mkdtemp

from typing import List, Tuple, Union

import click


LANGUAGES = [
    'deu',
    'eng'
]


def trackstr_to_list_of_int(trackstr: str) -> List[int]:
    """Converts a str with tracknumbers to a list of tracknumbers."""
    return [int(i) for i in trackstr.split(' ')]


def get_next_episode_title(
        directory: str,
        showname: str,
        season: int,
) -> Union[str, None]:
    episodes = sorted(os.listdir(directory))

    if not episodes:
        return '{}-s{:02d}e01.mkv'.format(showname, season)

    match_last_ep = re.match('^.*-s\d\de(\d\d).mkv$', episodes[-1])

    if match_last_ep:

        next_ep = int(match_last_ep.group(1)) + 1

        return '{}-s{:02d}e{:02d}.mkv'.format(showname, season, next_ep)

    else:
        return None


def split_position(item_list: List[str], value: str) -> Union[int, None]:
    for idx, val in enumerate(item_list):
        if val == value:
            return idx + 1
    return None


def local_dest_to_docker_dest(destination: str) -> Union[str, None]:
    username = os.getenv('HOSTUSER')
    splitted_destination = destination.split(os.sep)
    split_pos = split_position(splitted_destination, username)

    if split_pos and isinstance(split_pos, int):
        components = splitted_destination[split_pos:]

        return os.path.join('/data', '/'.join(components))

    else:
        return None


@click.command()
@click.option(
    '--language', '-l',
    type=click.Choice(LANGUAGES),
    default=tuple(LANGUAGES),
    multiple=True,
    help='Languages to use.'
)
@click.option(
    '--keep', '-k',
    is_flag=True,
    help='keep temp files.'
)
@click.option(
    '--temp', '-t',
    type=click.Path(exists=True),
    help='Use already existing temp directory.'
)
@click.option(
    '--showname', '-n',
    type=str,
    prompt=True,
    help='Show name.'
)
@click.option(
    '--season', '-s',
    type=int,
    prompt=True,
    help='Season name.',
)
@click.option(
    '--destination', '-d',
    prompt=True,
    help='Destination full path.'
)
def main(
        language: Tuple[str],
        keep: bool,
        temp: str,
        showname: str,
        season: int,
        destination: str,
) -> None:
    # set temp directoy for dvd rip
    if not temp:
        tmpdir = mkdtemp(dir='.')  # type: str
    else:
        tmpdir = temp

    # create destination directories
    if not os.path.exists(showname):
        click.secho('---> create show directory', fg='black', bg='white')
        os.makedirs(showname)

    final_destination = os.path.join(showname, 'Season {:02d}'.format(season))

    if not os.path.exists(final_destination):
        click.secho('---> create season directory', fg='black', bg='white')
        os.makedirs(final_destination)

    # copy dvd to harddrive
    if not os.path.exists(os.path.join(tmpdir, 'DVD')):

        click.secho('---> ripping dvd', fg='black', bg='white')
        subprocess.run(
            [
                'dvdbackup',
                '-M',
                '-i', '/dev/dvd',
                '-o', tmpdir,
                '-n', 'DVD'
            ],
            check=True,
        )

    # interface for track
    click.secho('---> scanning image', fg='black', bg='white')
    subprocess.run(
        [
            'transcode-video',
            '--scan',
            'DVD'
        ],
        cwd=tmpdir,
        check=True
    )

    tracks = click.prompt(
        'Please enter track number',
        type=str
    )  # type: str

    for track in trackstr_to_list_of_int(tracks):

        click.secho(
            '---> ripping video',
            fg='black', bg='white'
        )

        video_rip_cmd = [
            'transcode-video',
            '--title', str(track),
            '--crop', 'detect',
            '--main-audio={}'.format(language[0]),
        ]  # type: List[str]

        if len(language) >= 1:

            for lang in language[1:]:
                video_rip_cmd.append('--add-audio={}'.format(lang))

        # add subtitle option
        video_rip_cmd.append('--add-subtitle={}'.format(','.join(language)))

        # getting outputname
        outputname = get_next_episode_title(
            final_destination,
            showname, season
        )

        if outputname and isinstance(outputname, str):

            video_rip_cmd.extend(
                [
                    '-o',
                    outputname
                ]
            )

            # append directory with ripped dvd image
            video_rip_cmd.append('DVD')

            # run this thing
            subprocess.run(
                video_rip_cmd,
                cwd=tmpdir,
                check=True
            )

            # move file to destination directory
            shutil.move(os.path.join(tmpdir, outputname), final_destination)

        else:
            exit(1)

    # clean it up
    if not keep:
        click.secho(
            '---> deleting temp dir',
            fg='black', bg='white'
        )
        shutil.rmtree(tmpdir)
