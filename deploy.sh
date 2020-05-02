# Print the commands as they are being executed and fail or error
set +x
set +e

# Read the GitHub API PAT capable of accessing the GitHub Pages APIs
source token.sh
authorization="Authorization: token $token"

pagesBuildsUrl="https://api.github.com/repos/tomashubelbauer/musicblackholes.com/pages/builds"
pagesBuildsJson="pages-builds.json"

# Enqueue a GitHub Pages deployment using the API with the PAT
curl -s -f -X POST -H "$authorization" $pagesBuildsUrl > $pagesBuildsJson
status=$(jq '.status' $pagesBuildsJson | tr -d '"')
echo $status

if [ "$status" != "queued" ]
then
  exit 1
fi

pagesBuildsLatestUrl=$(jq '.url' $pagesBuildsJson | tr -d '"')
pagesBuildsLatestJson="pages-builds-latest.json"

rm $pagesBuildsJson

while true
do
  sleep 5
  curl -s -f -H "$authorization" $pagesBuildsLatestUrl > $pagesBuildsLatestJson
  status=$(jq '.status' $pagesBuildsLatestJson | tr -d '"')
  echo $status
  
  if [ "$status" = "built" ]
  then
    rm $pagesBuildsLatestJson

    exit
  fi
done
