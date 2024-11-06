import urllib.request
import http.cookiejar
import appdirs
import pathlib
import sys,os,os.path
from bs4 import BeautifulSoup

args = sys.argv
contestName = args[1]

cookie_path = pathlib.Path(appdirs.user_data_dir('online-judge-tools')) / 'cookie.jar'

cj = http.cookiejar.LWPCookieJar()
if os.path.exists(cookie_path):
    cj.load(cookie_path)
opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
r = opener.open('https://atcoder.jp/contests/' + contestName + '/tasks?lang=ja')
html = r.read().decode('utf-8')

soup = BeautifulSoup(html, "lxml")

tr_list = soup.find_all("tr")

for tr in tr_list:
    if tr.td == None:
        continue;
    td_list = tr.find_all("td")
    problem_name = td_list[0].get_text().lower()
    problem_url = td_list[0].a.attrs["href"]
    print(problem_name, problem_url)
