# https://blog.jupyter.org/inspector-jupyterlab-404cce3e1df6
# pip install docrepr jupyterlab_pygments
# Ctrl-I to inspect
c = get_config()
c.InteractiveShell.sphinxify_docstring = True
c.InteractiveShell.enable_html_pager = True
