# predict_bicycle_with_r

Predicting public bicycle usage 2019 based on time and weather variables with R

---

## 0. Basic information

repo 1. data_crawling <-- for collecting data from web database based on crawling with Python 3
repo 2. dataset <-- preprocess and processed dataset
repo 3. image <-- .png guide for addtional explaning dataset and variables   

.R file 1 SJH542_bicycle_a.R <-- for examining predicting results with R statistics 
.R file 2 SJH542_bicycle_c.R <-- for cleasing data
.R file 3 source_dataMining.R <-- Professor Ho won Jung's datamining package
.Rmd file 1 SJH542_bicycle_reports.Rmd <-- main file for testing the code from data collection to evaluating using by r statistics and dataset based on knitr

---

## 1. Author

JaehyungSeo (Jay) 

--- 

## 2. Contributor / Thanks

Professor Ho won Jung (Korea Univ. Business School)

---

## 3. Sources

(1) Fanaee-T, Hadi, and Gama, Joao, “Event labeling combining ensemble detectors and background knowledge”, 
Progress in Artificial Intelligence (2013): pp. 1-15, Springer Berlin Heidelberg,

URL: http://capitalbikeshare.com/system-data

(2) 서울열린데이터 광장 > 서울특별시 공공자전거 이용정보(시간대별
 - 서울특별시 공공자전거 시간대별 대여정보_201801_02.xlsx
 - 시간대별 총 대여횟수

URL: https://data.seoul.go.kr/dataList/datasetView.do?infId=OA-15245&srvType=F&serviceKind=1&currentPageNo=1

(3) 기상청 날씨누리 > 관측자료 > 도시별 현재날씨
- 종합 정보, 서울, 2018.01.01 ~ 2018.02.28
- 현재 일기, 현재 기온, 이슬점 온도, 체감 온도, 습도, 풍속

URL: http://www.weather.go.kr/weather/observation/currentweather.jsp

---

## 4. ChangeLog

Version 1. 2019.12.20
Lastest 2. 2020.01.24

---

## 5. How to Use

(1) Crawl the additional the data (if you need) using .py in data_crawling repository.
(2) Load dataset from dataset repository.
(3) Clean the dataset fitting on dimension and your purpose
(4) Use R statistics tools such as R-partition, Support vector machien, or random forest etc..
(5) If you want to evaluate your code, just run .RMD 

---

## 6. License

The MIT License (MIT)
Copyright (c) 2019 JaehyungSeo






