pagebreak = Style/pandoc_page_break.txt

CHAPTER_01 += intro.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += installation.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += tools_command_getting_started_linux.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += users_and_groups.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += modbits.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += nano.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += bash.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += processes.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += text.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += links_and_aliases.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += integration_excercise.md
CHAPTER_01 += ${pagebreak}
CHAPTER_02 += integration_test_part.md
CHAPTER_01 += ${pagebreak}
CHAPTER_02 += intro_part2.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += fedora.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += nm_to_networkd.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += internnetwork.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += systemd.md



CHAPTERS += $(CHAPTER_01) $(CHAPTER_02)


all:
	pandoc $(CHAPTERS) -o dist/linux_cursus_epub_nl.epub --css ./Style/base.css\

	pandoc $(CHAPTERS) -o dist/linux_cursus_nl.html --self-contained -s --toc --toc-depth=5  -c ./Style/github-pandoc.css

	wkhtmltopdf dist/linux_cursus_nl.html dist/linux_cursus_nl.pdf

	zip dist/linux_cursus_nl.zip dist/linux_cursus_nl.epub dist/linux_cursus_nl.html dist/linux_cursus_nl.pdf
