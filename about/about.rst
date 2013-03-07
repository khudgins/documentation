.. _about:

About
=====

This site is built using the `Sphinx Documentation Engine <http://sphinx-doc.org/>`_ 

The contents of the site are hosted in a publicly available github repository:

``git@github.com:Enstratius/documentation.git``

You are welcome to clone the contents and build your own local copy.

Local Build (HTML)
------------------

After cloning the repository, you can build the site locally using these steps:

#. Download the sphinx utility:

   * http://sphinx.pocoo.org/
   * Install python setup tools ( sudo port install py-setuptools )
   * sudo easy_install -U Sphinx

#. cd documentation/

#. make clean

#. make html

#. open ``_build/html/index.html`` in your browser

Sample Output
~~~~~~~~~~~~~

.. code-block:: text

   rm -rf _build/*
   sphinx-build -b html -d _build/doctrees   . _build/html
   Making output directory...
   Running Sphinx v1.1.3
   loading pickled environment... not yet created
   building [html]: targets for 190 source files that are out of date
   updating environment: 190 added, 0 changed, 0 removed
   reading sources... [100%] tutorials/wordpressdemo/wordpressdemo                                                                                                                                                 
   looking for now-outdated files... none found
   pickling environment... done
   checking consistency...
   done
   preparing documents... done
   writing output... [100%] tutorials/wordpressdemo/wordpressdemo                                                                                                                                                  
   writing additional files... search
   copying images... [100%] automation/deployment_configuration/./images/launchConfigurationVolumes.png                                                                                                            
   copying static files... done
   dumping search index... done
   dumping object inventory... done
   build succeeded, 2 warnings.
   
   Build finished. The HTML pages are in _build/html.

Local Build (LaTeX)
-------------------

.. note:: While the LaTeX build will succeed, the formatting for the content is not yet
   optimized for PDF. This will be done incrementally as the site content is standardized.

You will need to have a LaTeX engine such as MacTeX installed to use the Sphinx LaTeX
feature.

The site can also be compiled into a PDF document using LaTeX. To build the PDF, follow
the same steps as above except:

#. make clean

#. make latexpdf

Sample Output
~~~~~~~~~~~~~

.. code-block:: text

   rm -rf _build/*
   sphinx-build -b latex -d _build/doctrees   . _build/latex
   Making output directory...
   Running Sphinx v1.1.3
   loading pickled environment... not yet created
   building [latex]: all documents
   updating environment: 190 added, 0 changed, 0 removed
   reading sources... [100%] tutorials/wordpressdemo/wordpressdemo                                                                                                                                                 
   looking for now-outdated files... none found
   pickling environment... done
   
   <greatly truncated for brevity>
   
   <hundreds of lines of output here>
   
   <as the compilation occurs>
   
   Output written on Enstratius-SaaS.pdf (306 pages, 10405823 bytes).
   Transcript written on Enstratius-SaaS.log.
   pdflatex finished; the PDF files are in _build/latex.

The resulting PDF will be located in ``_build/latex/Enstratius-SaaS.pdf``
