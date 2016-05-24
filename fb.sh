#!/bin/bash

function downloadPhoto {
  output_dir=$1
  photo_id=$2
  token=$3
  echo Downloading photo $photo_id to $output_dir
  photo_json=`curl -sS -X GET "https://graph.facebook.com/v2.6/$photo_id?fields=images&access_token=$token"`

  photo_url=`jq -rM '.images|max_by(.width)|.source' <<< $photo_json`
  curl -sS -o $output_dir/$photo_id.jpg -X GET "$photo_url"
}

function downloadPhotos {
  output_dir=$1
  json=$2
  token=$3

  photos=(`jq -rM '.data|.[]|.id' <<< $json`)

  for i in ${photos[@]};
  do
    downloadPhoto $output_dir $i $token
  done
}

album_id=$1
output_dir=$2

token=`cat .fb_access_token`
limit=100

next_page_url="https://graph.facebook.com/v2.6/$album_id/photos?fields=link&limit=$limit&access_token=$token"

until [[ $next_page_url == 'null' ]]
do
  echo
  echo Reading photos list from $next_page_url
  json=`curl -sS -X GET $next_page_url`

  echo
  echo Downloading photos...
  downloadPhotos $output_dir $json $token

  next_page_url=`jq -rM .paging.next <<< $json`
done

exit 0
