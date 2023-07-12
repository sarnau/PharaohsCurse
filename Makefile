BIN           = ~/GitHub/cc65/bin/cl65
OBJDIR        = ./Objects

all:
	mkdir -p $(OBJDIR)/
	$(BIN) -C PharaohsCurse.cfg PharaohsCurse.s --start-addr 0x0480 -Ln $(OBJDIR)/object.vs -o $(OBJDIR)/object.prg

clean:
	rm -rf $(OBJDIR)/
