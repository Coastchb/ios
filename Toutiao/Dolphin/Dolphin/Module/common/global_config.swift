//
//  global_config.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/16.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

let STARED_TYPE_KEY = "STARED_ITEM_TYPE"
let STARED_ID_KEY = "STARED_ITEM_ID"
let STARED_DATE_KEY = "STARED_DATE"

let USER_INFO_KEY = "USER_INFO"

let USER_TAGS_KEY = "USER_TAGS"

let USER_AVATAR_KEY = "USER_AVATAR"
let ANONYMOUS_USER_AVATAR_KEY = "ANONYMOUS_USER_AVATAR"

let USER_DATA_BASE_DIR = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

let PASSWD_MIN_LEN = 6

let AVATAR_CORNER_RADIUS = 10
let LOGO_CORNER_RADIUS = 3

let LOGIN_STATUS_CHANGED_KEY = "LOGIN_STATUS_CHANGED"
let TAGS_CHANGED_KEY = "TAGS_CHANGED"

let WEBSITE_LOGO_KEY = "WEBSITE_LOGO"

let USER_AVATAR_PREFIX = "http://9.73.179.124/user_avatar" //"http://localhost:8000/user_avatar"
let WEBSITE_LOGO_PREFIX = "http://9.73.179.124/website_logo" // "http://localhost:8000/website_logo"  // "http" is necessary!
let DEFAULT_WEBSITE_LOGO_KEY = "default_website_logo"
let DEFAULT_USER_AVATAR = "default_user_avatar.jpg"
let ANONYMOUS_USER_NAME = "ANONYMOUS"

let OFFLINE_OP_PROMPT = "请联网后操作"
let OFFLINE_OP_PROMPT_DELAY = 0.5

let OFFLINE_LOAD_PROMPT = "未联网，加载失败"
let OFFLINE_LOAD_PROMPT_DELAY = 1.0

let NETWORK_SLOW_PROMPT = "网络状态差，请稍后重试"
let NETWORK_SLOW_PROMPT_DELAY = 1.0

let SERVER_CRASH_ERROR_MSG = "无法连接到目标服务器，请刷新页面重试"
let SERVER_CRASH_PROMPT = "服务器端发生错误，请等待修复。"
let SERVER_CRASH_PROMPT_DELAY = 2.0

let OP_ERROR_PROMPT = "操作失败"
let OP_ERROR_PROMPT_DELAY = 0.5

let UNKNOWN_ERROR_PROMPT = "未知错误，数据请求失败"
let UNKNOWN_ERROR_PROMPT_DELAY = 1.5

var SERVER_CRASHED = false

let FEEDBACK_PLACEHOLDER = "请写下您的宝贵意见..."
let TAG_DESCRIPTION_PLACEHOLDER = "请简单介绍新增标签，比如所属专业/行业等..."
let TUTORIAL_DESCRIPTION_PLACEHOLDER = "请简单介绍发布的教程，比如所属专业/行业、相关的标签等..."
let NEW_PHONE_NUM_PLACEHOLDER = "请输入11位新手机号"
let PHONE_NUM_PLACEHOLDER = "请输入11位手机号"
