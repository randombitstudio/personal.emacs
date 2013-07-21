# Emacs Development Environment Setup

This is a personal repository on which I won't provide any support,
fix style issues etc.

## What?

The setup.sh file configures an emacs setup that I use from within
[tmux](http://tmux.sourceforge.net/) locally or via ssh.

The deployment contains specific configuration for the following
languages:

* *PHP* - latest version of alternative php-mode from github
* *Javascript* - js mode + some small config tweaks. 
* *Clojure* (clojure mode + ac-slime + rainbow-delimiters + nrepl)
* *Ruby* (experimental, while I figure out what do I need for
  effective RoR development)

and goodies:
* emacs-nav - Easy file navigation buffer.
* auto complete - Self explanatory.
* yasnippet - language specific expansion snippets, I'll add my own to
a separate repository.
* psvn - Subversion in emacs integration(has limitations so,
  familiarity with the command line is required)
* magit - Git in emacs integration(same as above)

If you are new to emacs, or are looking to learn, I strongly suggest
starting with the excellent
[starter-kit](https://github.com/technomancy/emacs-starter-kit) and
then figuring out what exactly do you want emacs to do for you from
there. 
