from unittest.mock import patch

import pytest

import rip_show


@pytest.mark.parametrize('input,expected', [
    ('3', [3]),
    ('1 3 4', [1, 3, 4]),
])
def test_trackstr_to_list_of_int(input, expected):
    assert rip_show.trackstr_to_list_of_int(input) == expected


@patch('rip_show.os.listdir')
def test_get_next_episode_title(mock_listdir):
    mock_listdir.return_value = ['foo-s01e01.mkv', 'foo-s01e02.mkv']

    assert rip_show.get_next_episode_title(
        '/foo', 'foo', 1
    ) == 'foo-s01e03.mkv'


@pytest.mark.parametrize('item_list,value,expected', [
    (
        ['a', 'b', 'c'],
        'b',
        2
    ),
    (
        ['', 'home', 'marv', 'foo', 'bar'],
        'marv',
        3
    )
])
def test_split_position(item_list, value, expected):
    assert rip_show.split_position(item_list, value) == expected


@patch('rip_show.os.getenv')
def test_local_dest_to_docker_dest(mock_getenv):
    mock_getenv.return_value = 'marv'

    assert rip_show.local_dest_to_docker_dest(
        '/home/marv/foo/bar'
    ) == '/data/foo/bar'
