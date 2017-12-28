# Override the arch with `make ARCH=i386`
ARCH   ?= $(shell flatpak --default-arch)
REPO   ?= repo


FILES=com.kevlopez.Sdk.json os-release issue

all: ${REPO} ${FILES}
	flatpak-builder --force-clean --ccache --require-changes --repo=${REPO} --arch=${ARCH} \
		--subject="build of com.kevlopez.Sdk, `date`" \
		${EXPORT_ARGS} sdk com.kevlopez.Sdk.json

${REPO}:
	ostree  init --mode=archive-z2 --repo=${REPO}

check:
	json-glib-validate org.gnome.Sdk.json
