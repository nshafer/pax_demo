# PaxDemo

This is a very basic Phoenix project that demonstrates how Pax works. It will load data on classic literature
from Project Gutenberg.

To get started:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Using for Pax development

This demo can also be used as an integrated environment for developing and testing Pax. This includes setting up
Phoenix.CodeReloader and Phoenix.LiveReloader to watch for changes in the Pax dir and reload your browser.

To take advantage of this:
- Clone this repo to a local directory: `git clone https://github.com/nshafer/pax_demo.git`
- Clone the Pax repo next to it: `git clone https://github.com/nshafer/pax.git`
- Configure this project o use the local pax checkout instead of hex: `echo "../pax" > local/pax_path.txt`
- Rerun `mix deps.get`
