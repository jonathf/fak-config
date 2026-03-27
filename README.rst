fak-config
==========

My personal FAK configuration repository.

`Zilpzalp keyboard <https://github.com/kilipan/zilpzalp>`_ |
`Miao ch552t MCU board <https://github.com/kilipan/miao>`_ |
`FA Keyboard firmware <https://github.com/semickolon/fak>`_ |
`Nickel config language <https://nickel-lang.org>`_

Compiling
---------

The file ``keyboards/{name}/keyboard.ncl`` defines the keyboard hardware
layout, while all Nickel files in the ``keyboards/{name}/keymaps`` contains
the keymaps that defines the behavior of the keyboard.

Pushing changes to the ``main`` branch will trigger Github Actions that
generate flashable ``.ihx`` files.

Flashing
--------

To allow for the keyboard to be interfaced in Linux, create the file
``/etc/udev/rules.d/50-wchisp.rules`` and fill it with the followig content:

.. code-block:: ini

  SUBSYSTEMS=="usb", ATTRS{idVendor}=="4348", ATTRS{idProduct}=="55e0", GROUP="uucp", MODE="0666"

Save file, and log out and in again.

The flashing is done using [Wchisp flash tool](https://github.com/ch32-rs/wchisp). Install it by running:

.. code-block:: bash

   cargo install wchisp --git https://github.com/ch32-rs/wchisp

To prepare the keyboard for flashing, hold the left button on the Miao while
plugging in the usb cable. Running ``lsusb`` (with another keyboard) will list
the keyboard like this:

.. code-block::

  Bus 003 Device 010: ID 4348:55e0 WinChipHead

The keyboard is now ready to be flashed. This can be done by running the
command:

.. code-block::

   wchisp my_keyboard.ihx

GitHub Codespace
~~~~~~~~~~~~~~~~

The quickest and easiest way to get started is using `GitHub
Codespaces <https://github.com/features/codespaces>`__. You don’t have
to go through the trouble of setting up the development environment.
Everything is remote, comes preloaded, and it just works.

1. Fork this repo
2. Create a new codespace
3. Wait for the environment to be loaded in the terminal until you can
   enter commands

The only thing that won’t work from a remote setup is, of course,
flashing. You’ll have to do that locally with
```wchisp`` <https://github.com/ch32-rs/wchisp/releases/tag/nightly>`__.
Thankfully, ``wchisp`` provides prebuilt binaries so getting that set up
on your local machine is very easy.

1. In your codespace, ``fak compile -kb [keyboard] -km [keymap]``. It
   will print the path(s) where it put the firmware.
2. Download the ``.ihx`` file(s) located in the printed path(s).
3. In your local machine,
   ``wchisp flash [keyboard].[keymap].central.ihx``.
4. And then if you have a split,
   ``wchisp flash [keyboard].[keymap].peripheral.ihx``.

Alternatively, you can push your changes, wait a bit, then you will find
all ready-to-flash ``.ihx`` files in the latest release. From there,
download the ones you need, then flash with ``wchisp``.

If, for whatever reason, you’re getting ``fak: command not found``,
enter ``nix develop`` then you should be back up.

Nix
~~~

If you have Nix installed on your system, a Nix flake is provided.

1. Fork and clone this repo
2. ``nix develop`` (or if you have ``direnv``, just ``direnv allow``)

Manual setup
~~~~~~~~~~~~

Requirements: - ```sdcc``
4.2.0 <https://sourceforge.net/projects/sdcc/files>`__ - ```nickel``
1.5.0 <https://github.com/tweag/nickel/releases/tag/1.5.0>`__ -
```python`` 3.11.6 <https://www.python.org/downloads>`__ - ```meson``
1.2.3 <https://mesonbuild.com/>`__ - ```ninja``
1.11.1 <https://github.com/ninja-build/ninja/releases/tag/v1.11.1>`__ -
```wchisp`` <https://github.com/ch32-rs/wchisp/releases/tag/nightly>`__

With manual setup, the ``fak`` command isn’t included. Use
``python fak.py`` in place of ``fak`` (e.g., ``fak clean`` becomes
``python fak.py clean``). Alternatively, you may make a shell alias for
``fak`` if you wish.

Commands
--------

Now that you have your development environment set up and ready,
compiling is as easy as ``fak compile -kb [keyboard] -km [keymap]``. You
may omit ``-km [keymap]`` if keymap is “default” (e.g.,
``fak compile -kb [keyboard]``). This will also print the path(s) where
it put the firmware files in, which is helpful in a remote setup.

If you’re using a local setup, you can flash directly with
``fak flash -kb [keyboard] -km [keymap]``. Then if you have a split,
flash the peripheral side with
``fak flash_p -kb [keyboard] -km [keymap]``. Likewise, you may omit
``-km [keymap]`` if keymap is “default”.

If something’s off, wrong, or not working, cleaning your build files
might help with ``fak clean``.

To compile every keyboard with its every keymap, enter
``fak compile_all``. Whenever you push, this is what GitHub Actions
actually does behind the scenes to update the latest release with all
ready-to-flash ``.ihx`` files.

Included Nickel paths
---------------------

All Nickel files are evaluated with two include paths: - ``ncl``
directory in ```fak`` <https://github.com/semickolon/fak>`__. This makes
``import "fak/somefile.ncl"`` possible. - ``shared`` directory in this
repo. This makes ``import "lib/somefile.ncl"`` possible.

We do this so you don’t have to do something like
``import ../../../subprojects/fak/ncl/fak/somefile.ncl``. Yeah.
Horrible.

Migrating from FAK forks
------------------------

If you’re one of the OGs who use FAK before user config repos existed
and you want to migrate:

1. Fork and clone this repo.
2. Copy over your keyboards and keymaps in ``keyboards`` while
   respecting the file structure.
3. Replace all those (horrible) relative ``fak`` imports with
   ``import "fak/somefile.ncl"``.

Switching versions
------------------

1. (Optional) To use a different FAK repo, like your own fork, change
   the ``url`` in ``subprojects/fak.wrap``.
2. To use a different version, change the ``revision`` in
   ``subprojects/fak.wrap``. This can be a commit hash (recommended) or
   a tag.
3. ``fak update``.

⚠️ This affects all your keyboards and keymaps, so if there’s a breaking
change in the version and/or repo you’re switching to, you’ll have to
fix that in **all** your Nickel files.
