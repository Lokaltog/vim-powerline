if ! has('python')
	echohl ErrorMsg
	echomsg 'You need vim compiled with Python 2 support for Powerline to work. Please consult the documentation for installation instructions: http://lokaltog.github.com/powerline/'
	echohl None
	finish
endif

python <<EOF
try:
	from powerline.ext.vim import source_plugin
	source_plugin()
except ImportError:
	print('You need to install the Powerline Python package. Please consult the documentation for installation instructions: http://lokaltog.github.com/powerline/')
EOF
