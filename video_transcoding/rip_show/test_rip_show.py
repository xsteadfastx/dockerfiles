import pytest

import rip_show


@pytest.mark.parametrize('input,expected', [
    ('3', [3]),
    ('1 3 4', [1, 3, 4]),
])
def test_trackstr_to_list_of_int(input, expected):
    assert rip_show.trackstr_to_list_of_int(input) == expected


@pytest.mark.parametrize('datafile,lang,expected', [
    ('track_info0.txt', 'de', '1'),
    ('track_info0.txt', 'en', '0'),
    ('track_info1.txt', 'de', None),
])
def test_get_subtitle_id(datafile, lang, expected):
    with open('testdata/{}'.format(datafile), 'r') as f:
        testdata = f.read()

    assert rip_show.get_subtitle_id(lang, testdata) == expected
