{ pkgs ? import <nixpkgs> {} }:

let start-editor = pkgs.writeShellScriptBin "start-editor" ''
	[[ ! -d /tmp/keymap-editor ]] && \
		git clone https://github.com/nickcoutsos/keymap-editor /tmp/keymap-editor

	cd /tmp/keymap-editor
	ln -s ${builtins.toString ./.} ./zmk-config

	[[ -d node_modules ]] || npm i
	npm run dev
'';

in pkgs.mkShell {
	name = "keymap-editor";

	buildInputs = with pkgs; [ start-editor nodejs ];
}
