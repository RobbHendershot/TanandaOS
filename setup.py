"""
Utility to configure and build the Tananda spin of Fedora made for the hacker/maker community.
"""
from setuptools import find_packages, setup

dependencies = ['click']

setup(
    name='tananda-os-builder',
    version='24',
    url='https://github.com/RobbHendershot/tananda-os-builder',
    license='BSD',
    author='Robb Hendershot',
    author_email='robb.hendershot@gmail.com',
    description='Utility to configure and build the Tananda spin of Fedora made for the hacker/maker community.',
    long_description=__doc__,
    packages=find_packages(exclude=['tests']),
    include_package_data=True,
    zip_safe=False,
    platforms='any',
    install_requires=dependencies,
    entry_points={
        'console_scripts': [
            'tananda-os-builder = tananda_os_builder.cli:main',
        ],
    },
    classifiers=[
        # As from http://pypi.python.org/pypi?%3Aaction=list_classifiers
        # 'Development Status :: 1 - Planning',
        # 'Development Status :: 2 - Pre-Alpha',
        # 'Development Status :: 3 - Alpha',
        'Development Status :: 4 - Beta',
        # 'Development Status :: 5 - Production/Stable',
        # 'Development Status :: 6 - Mature',
        # 'Development Status :: 7 - Inactive',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Operating System :: POSIX',
        'Operating System :: MacOS',
        'Operating System :: Unix',
        'Operating System :: Windows',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3',
        'Topic :: Software Development :: Libraries :: Python Modules',
    ]
)
