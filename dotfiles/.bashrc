alias clang++="clang++-16"

function new () {
  if [[ $# != 1 && $# != 2 ]]; then
    echo "Usage: new {contestName} or new {contestName}/{problemName} or new {contestName} {problemName}"
    return 1
  fi
  cd /kyopro

  if [[ $# -eq 1 ]]; then
    if [[ $1 == *"/"* ]]; then
      contestName=$(echo $1 | cut -d'/' -f1)
      problemName=$(echo $1 | cut -d'/' -f2)
      mkdir -p $contestName/$problemName
      cd $contestName/$problemName
      oj d https://atcoder.jp/contests/${contestName}/tasks/${contestName}\_${problemName}
      cp /kyopro/tmp/* .
    else
      contestName=$1
      python3 contest.py $contestName | xargs -n2 bash -c "mkdir -p $contestName/\$0; cd $contestName/\$0; oj d https://atcoder.jp\$1; cp /kyopro/tmp/* ."
      cd $contestName
    fi
  elif [[ $# -eq 2 ]]; then
    contestName=$1
    problemName=$2
    mkdir -p $contestName/$problemName
    cd $contestName/$problemName
    oj d https://atcoder.jp/contests/${contestName}/tasks/${contestName}\_${problemName}
    cp /kyopro/tmp/* .
  else
    echo "Usage: new {problemUrl} or new {contestName}/{problemName} or new {contestName} {problemName}"
    return 1
  fi
}
