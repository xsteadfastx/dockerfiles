import re

import shutil

import subprocess

from os import path

from tempfile import mkdtemp

from typing import List, Tuple, Union

import click


LANGUAGES = {
    'german': {
        '1': 'de',
        '2': 'deu'
    },
    'english': {
        '1': 'en',
        '2': 'eng'
    }
}


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


@click.command()
@click.option(
    '--language', '-l',
    help='Languages to use.',
    multiple=True,
    type=click.Choice(list(LANGUAGES.keys())),
    default=tuple(LANGUAGES.keys())
)
@click.option(
    '--keep', '-k',
    help='keep temp files.',
    is_flag=True
)
@click.option(
    '--temp', '-t',
    help='Use already existing temp directory.',
    type=click.Path(exists=True)
)
def main(language: Tuple[str], keep: bool, temp: str):
    if not temp:
        tmpdir = mkdtemp(dir='.')  # type: str
    else:
        tmpdir = temp

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
        click.secho('---> getting subtitle id', fg='black', bg='white')
        track_info_raw = subprocess.run(
            [
                'mplayer',
                '-dvd-device', 'DVD',
                'dvd://{}'.format(track),
                '-vo', 'null',
                '-ao', 'null',
                '-frames', '0',
                '-identify'
            ],
            cwd=tmpdir,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True
        )

        if isinstance(track_info_raw.stdout, bytes):
            track_info = track_info_raw.stdout.decode('utf-8')
        else:
            track_info = track_info_raw.stdout

        for lang in language:

            sid = get_subtitle_id(LANGUAGES[lang]['1'], track_info)

            if sid:

                file_base = '{}-{}'.format(track, lang)

                click.secho(
                    '---> ripping subtitle {}'.format(lang),
                    fg='black', bg='white'
                )
                subprocess.run(
                    [
                        'mencoder',
                        '-dvd-device', 'DVD',
                        'dvd://{}'.format(track),
                        '-nosound',
                        '-ovc', 'frameno',
                        '-o', '/dev/null',
                        '-slang', LANGUAGES[lang]['1'],
                        '-sid', sid,
                        '-vobsuboutindex', '0',
                        '-vobsuboutid', LANGUAGES[lang]['1'],
                        '-vobsubout', file_base
                    ],
                    cwd=tmpdir,
                    check=True
                )

                click.secho(
                    '---> converting subtitle to SRT',
                    fg='black', bg='white'
                )
                subprocess.run(
                    [
                        'vobsub2srt',
                        file_base
                    ],
                    cwd=tmpdir,
                    check=True
                )

            else:
                click.secho(
                    'could not find subtitle language',
                    fg='red', bg='white'
                )

        click.secho(
            '---> ripping video',
            fg='black', bg='white'
        )

        video_rip_cmd = [
            'transcode-video',
            '--title', str(track),
            '--main-audio={}'.format(LANGUAGES[language[0]]['2'])
        ]

        for lang in language[1:]:
            video_rip_cmd.append(
                '--add-audio={}'.format(LANGUAGES[lang]['2'])
            )

        video_rip_cmd.append('DVD')

        subprocess.run(
            video_rip_cmd,
            cwd=tmpdir,
            check=True
        )

    # clean it up
    if not keep:
        shutil.rmtree(tmpdir)
