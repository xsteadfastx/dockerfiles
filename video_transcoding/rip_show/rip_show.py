import re

import shutil

import subprocess

from os import path

from tempfile import mkdtemp

from typing import List, Tuple, Union

import click


def trackstr_to_list_of_int(trackstr: str) -> List[int]:
    """Converts a str with tracknumbers to a list of tracknumbers."""

    return [int(i) for i in trackstr.split(' ')]


def get_subtitle_id(language: str, track_info: str) -> Union[int, None]:
    search_sid = re.search(
        'subtitle\s\(\ssid\s\):\s(\d)\slanguage:\s{}'.format(language),
        track_info
    )

    if search_sid and search_sid.group(1):
        return int(search_sid.group(1))
    else:
        return None


@click.command()
@click.option(
    '--language', '-l',
    help='Languages to use.',
    multiple=True,
    type=click.Choice(['de', 'en']),
    default=('de', 'en')
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

    dvd_image = path.join(tmpdir, 'DVD')

    # copy dvd to harddrive
    if not path.exists(dvd_image):

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
            dvd_image
        ],
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
                '-dvd-device', dvd_image,
                'dvd://{}'.format(track),
                '-vo', 'null',
                '-ao', 'null',
                '-frames', '0',
                '-identify'
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True
        )

        track_info = track_info_raw.stdout.decode('utf-8')

        for lang in language:

            sid = get_subtitle_id(lang, track_info)

            if sid:
                click.secho(
                    '---> ripping subtitle {}'.format(lang),
                    fg='black', bg='white'
                )
                subprocess.run(
                    [
                        'mencoder',
                        '-dvd-device', dvd_image,
                        'dvd://{}'.format(track),
                        '-nosound',
                        '-ovc', 'frameno',
                        '-o', '/dev/null',
                        '-slang', lang,
                        '-sid', str(sid),
                        '-vobsuboutindex', '0',
                        '-vobsuboutid', lang,
                        '-vobsubout', lang
                    ],
                    check=True
                )

                click.secho(
                    '---> converting subtitle to SRT',
                    fg='black', bg='white'
                )
                subprocess.run(
                    [
                        'vobsub2srt',
                        lang
                    ],
                    check=True
                )

    # clean it up
    if not keep:
        shutil.rmtree(tmpdir)
