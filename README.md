## Mock Server

為了前後端開發速度不一的 Mock API Server

[![Build Status](https://travis-ci.org/commandp/mock-server.svg?branch=develop)](https://travis-ci.org/commandp/mock-server)
[![Code Climate](https://codeclimate.com/github/commandp/mock-server/badges/gpa.svg)](https://codeclimate.com/github/commandp/mock-server)
[![Test Coverage](https://codeclimate.com/github/commandp/mock-server/badges/coverage.svg)](https://codeclimate.com/github/commandp/mock-server/coverage)

## Requirements

* Ruby 2.3.0
* PostgreSQL 9.4 +

## Setup

1. Get the code
```
$ git clone git@github.com:commandp/mock-server.git
```

2. Setup
```
$ bin/setup
```

## 使用 Amazon S3 作為檔案上傳圖床

如果你希望檔案的部分使用 S3 作為圖床你需要加入下列環境變數，否則預設將會是上傳到本機

```
S3_BUCKET
S3_REGION
S3_ACCESS_KEY_ID
S3_SECRET_ACCESS_KEY
```

## Rollbar

本專案使用 Rollbar 作為 error tracking，你可以加入以下環境變數使用 Rollbar

```
ROLLBAR_ACCESS_TOKEN
```

## TODO
* 定義安全規則讓 template 中的自定變數符合安全規則
