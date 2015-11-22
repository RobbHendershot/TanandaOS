BASE_DIR="$HOME/workspace/TanandaOS"
REL_NUM=23
DIST_NAME=Tananda-$REL_NUM-x86_64-`date +%F`

sudo livecd-creator \
--config=$BASE_DIR/kickstarts/tananda-final.ks \
--fslabel=$DIST_NAME \
--releasever=$REL_NUM \
--title=$DIST_NAME \
--product=$DIST_NAME \
--cache=$BASE_DIR/cache/ \
--tmpdir=$BASE_DIR/tmp/ \
--verbose \
|& tee ./iso_build_log

