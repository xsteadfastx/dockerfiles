from setuptools import setup


setup(
    name='rip_show',
    py_modules=['rip_show'],
    install_requires=[
        'click',
        'typing',
    ],
    entry_points='''
        [console_scripts]
        rip_show=rip_show:main
    ''',
    extras_require={
        'dev': [
            'flake8',
            'flake8-import-order',
            'mypy'
        ],
        'test': [
            'pytest'
        ]
    }
)
