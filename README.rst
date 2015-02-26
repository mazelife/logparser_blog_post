High-performance Log Parsing in Haskell
=======================================

This project includes a blog post (written in `reStructured Text <http://docutils.sourceforge.net/rst.html>`_) and a sample Haskell project that implements the code example shown in the blog post.

Publishing the blog post
-------------------------

`Sphinx <http://sphinx-doc.org/>`_ is your best bet as it will give you output in a nice format with syntax highlighting for all code snippets. Installation/publishing instructions are::

	?> virtualenv blogpost
	?> activate blogpost/bin/activate
	?> pip install sphinx
	?> cd doc
	?> make singlehtml  # publish the HTML verison with sphinx
	?> open _build/singlehtml/index.html -a safari  # or open _build/html/index.html -a chrome


Building the Haskell project 
-----------------------------


There are a couple of preinstallation steps that vary depending on your platform.

OS X
^^^^^

#. `Install <http://new-www.haskell.org/downloads/osx>`_ GHC and Cabal
#. Install the PCRE library: ``?> brew install pcre``

Ubuntu
^^^^^^
#. `Install <http://new-www.haskell.org/downloads/linux>`_ GHC and Cabal
#. Install the PCRE library: ``?> sudo apt-get install libpcre3-dev``


Once these platform-specific steps are done, you can use `cabal <https://www.haskell.org/cabal/>`_, Haskell's package management and build system to do the rest. Run cabal commands from the root directory of this project after you clone it from GitHub. Begin by installing the project's dependencies:: 
	
	?> cabal update  #  This will download the most recent list of packages.
	?> cabal install --only-dependencies 

The install step will take a some time as all dependencies are bing downloaded and compiled. When that step is complete, you can build the project::
	
	?> cabal build

This project builds an executable that will be located in ``dist/build/parser/``. 


