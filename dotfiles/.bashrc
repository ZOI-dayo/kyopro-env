alias clang++="clang++-16"
function new () {
  if [[ $# != 1 && $# != 2 ]]; then
    echo "Usage: new {problemUrl} or new {contestName}/{problemName} or new {contestName} {problemName}"
    return 1
  fi
  cd /kyopro

  if [[ $# -eq 1 ]]; then
    if [[ $1 == *"/"* ]]; then
      contestName=$(echo $1 | cut -d'/' -f1)
      problemName=$(echo $1 | cut -d'/' -f2)
      oj d https://atcoder.jp/contests/${contestName}/tasks/${contestName}\_${problemName}
    else
      oj d $1
    fi
  elif [[ $# -eq 2 ]]; then
    contestName=$1
    problemName=$2
    oj d https://atcoder.jp/contests/${contestName}/tasks/${contestName}\_${problemName}
  else
    echo "Usage: new {problemUrl} or new {contestName}/{problemName} or new {contestName} {problemName}"
    return 1
  fi
}
