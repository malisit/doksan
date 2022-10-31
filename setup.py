import pathlib
from setuptools import setup, find_packages

HERE = pathlib.Path(__file__).parent

README = (HERE / "README.md").read_text()

setup(
    name="doksan",
    version="0.2.2",
    description="Get soccer results and fixtures like a hacker.",
    long_description=README,
    long_description_content_type="text/markdown",
    url="https://github.com/malisit/doksan",
    author="Muhammed Sit",
    author_email="masit@outlook.com",
    license="MIT",
    classifiers=[
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
    ],
    packages=find_packages(),
    include_package_data=True,
    install_requires=["bs4"],
    entry_points={
        "console_scripts": [
            "doksan=doksan.doksan:main",
        ]
    },
)