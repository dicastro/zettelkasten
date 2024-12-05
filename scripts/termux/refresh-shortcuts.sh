#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

SHORTCUTS_DIR="${HOME}/.shortcuts"
mkdir -p "$SHORTCUTS_DIR"

cat << EOF > "${SHORTCUTS_DIR}/logseq-push.sh"
#!/bin/bash
bash $SCRIPT_DIR/push.sh
EOF
chmod +x "${SHORTCUTS_DIR}/logseq-push.sh"

cat << EOF > "${SHORTCUTS_DIR}/logseq-pull.sh"
#!/bin/bash
bash $SCRIPT_DIR/pull.sh
EOF
chmod +x "${SHORTCUTS_DIR}/logseq-pull.sh"

cat << EOF > "${SHORTCUTS_DIR}/logseq-log.sh"
#!/bin/bash
bash $SCRIPT_DIR/log.sh
EOF
chmod +x "${SHORTCUTS_DIR}/logseq-log.sh"

cat << EOF > "${SHORTCUTS_DIR}/logseq-status.sh"
#!/bin/bash
bash $SCRIPT_DIR/status.sh
EOF
chmod +x "${SHORTCUTS_DIR}/logseq-status.sh"

cat << EOF > "${SHORTCUTS_DIR}/logseq-clean.sh"
#!/bin/bash
bash $SCRIPT_DIR/clean.sh
EOF
chmod +x "${SHORTCUTS_DIR}/logseq-clean.sh"