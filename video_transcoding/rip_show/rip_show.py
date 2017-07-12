import re

import shutil

import subprocess

from os import listdir, makedirs, path

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


def get_subtitle_id(language: str, track_info: str) -> Union[str, None]:
    """Searches for subtitle id."""
    search_sid = re.search(
        'subtitle\s\(\ssid\s\):\s(\d)\slanguage:\s{}'.format(language),
        track_info
    )

    if search_sid and search_sid.group(1):
        return search_sid.group(1)
    else:
        return None


def get_next_episode_title(
        directory: str,
        showname: str,
        season: int,
) -> Union[str, None]:
    episodes = sorted(listdir(directory))

    if not episodes:
        return '{}-s{:02d}e01.mkv'.format(showname, season)

    match_last_ep = re.match('^.*-s\d\de(\d\d).mkv$', episodes[-1])

    if match_last_ep:

        next_ep = int(match_last_ep.group(1)) + 1

        return '{}-s{:02d}e{:02d}.mkv'.format(showname, season, next_ep)

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
def main(
        language: Tuple[str],
        keep: bool,
        temp: str,
        showname: str,
        season: int
) -> None:
    # set temp directoy for dvd rip
    if not temp:
        tmpdir = mkdtemp(dir='.')  # type: str
    else:
        tmpdir = temp

    # create destination directories
    if not path.exists(showname):
        click.secho('---> create show directory', fg='black', bg='white')
        makedirs(showname)

    destination = path.join(showname, 'Season {:02d}'.format(season))

    if not path.exists(destination):
        click.secho('---> create season directory', fg='black', bg='white')
        makedirs(destination)

    # copy dvd to harddrive
    if not path.exists(path.join(tmpdir, 'DVD')):

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
        ]

        if len(language) >= 1:
            for lang in language[1:]:
                video_rip_cmd.append('--add-audio={}'.format(lang))

        # add subtitle option
        video_rip_cmd.append('--add-subtitle={}'.format(','.join(language)))

        # getting outputname
        outputname = get_next_episode_title(destination, showname, season)
        if not outputname:
            exit(1)

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
        shutil.move(path.join(tmpdir, outputname), destination)

    # clean it up
    if not keep:
        click.secho(
            '---> deleting temp dir',
            fg='black', bg='white'
        )
        shutil.rmtree(tmpdir)
