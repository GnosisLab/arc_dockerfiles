# Python Programming Guide

Follow the PEP 8 Python style guide, except uses 2 spaces instead of 4. Please
conform to the Google Python Style Guide, and use `pylint` to check your Python
changes. Use the `yapf` auto-formatter to avoid arguing over formatting.

Also, check [Google Python guide](https://github.com/google/styleguide/blob/gh-pages/pyguide.md).


```python
pip install pylint yapf isort --user
wget -O .style.yapf https://raw.githubusercontent.com/GnosisLab/Coding_Guide/developement/style.yapf
wget -O .pylintrc https://google.github.io/styleguide/pylintrc
```

## YAPF style guide

Create a file named `.style.yapf`

```
[style]
based_on_style = google
indent_width = 2
spaces_before_comment = 2
split_before_logical_operator = true
```
