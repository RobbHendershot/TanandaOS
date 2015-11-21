sudo livecd-creator \
--config=./my_kickstarts/tananda-live-cinnamon.ks \
--fslabel=Tananda-23-x86_64-`date +%F` \
--releasever=23 \
--title=Tananda-23-x86_64-`date +%F` \
--product=Tananda-23-x86_64-`date +%F` \
--cache=/home/tananda/cache/ \
--tmpdir=/home/tananda/tmp/ \
--verbos \
|& tee ./out

