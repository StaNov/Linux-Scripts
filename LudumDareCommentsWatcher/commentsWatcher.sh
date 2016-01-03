COMMENT="<div class = 'comment'>";

if [ -z "$1" ]; then
  echo "Usage:";
  echo "./commentsWatcher.sh \"http://ludumdare.com/compo/ludum-dare-34/?action=preview&uid=55257\"";
  exit 1;
fi

NEWOCCURENCES=0;

echo "";
echo "==========================================================";
echo "Ludum Dare Comments Watcher by StaNov 2015 (www.StaNov.cz)";
echo "==========================================================";
echo "";
echo "Waiting for new comments for your game...";

while :
do
  FILE=$(wget -qO- "$1");
  COMMENTS=$(grep -o "$COMMENT" <<< $FILE | wc -l);
  
  if [ $NEWOCCURENCES -eq 0 ]; then
    NEWOCCURENCES=$COMMENTS;
  fi
  
  OLDOCCURENCES=$NEWOCCURENCES;
  NEWOCCURENCES=$COMMENTS;
  
  if [ $OLDOCCURENCES -ne $NEWOCCURENCES ]; then
    echo "NEW COMMENT!"
    mpg123 -q "Ta Da-SoundBible.com-1884170640.mp3"
  fi

  sleep 5;
done
