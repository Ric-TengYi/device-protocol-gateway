# 设备协议网关

面向 JetLinks/业务平台的轻量设备控制中间件。网关订阅 EMQX MQTT 指令，按厂商路由到海康 ISUP 或澳盾森林哨位系统，并发布统一执行回执。

## 已实现

- MQTT 3.1.1、QoS 1、自动重连、指令订阅与回执发布
- 指令格式校验、过期判断、进程内幂等控制
- 澳盾登录及 Token 缓存、LED 文字、WAV 语音、远程喊话、部件开关和状态查询
- 海康设备在线注册表、SDK 动态库加载边界、ISAPI/私有协议透传适配框架
- Docker Compose、外置配置、Actuator 健康检查和日志挂载

## 重要说明

海康 ISUP SDK 通用能力与设备型号均已确认，但 LED、语音控制所需的实际 URI/私有报文需由设备厂商提供。当前实现将该部分隔离在 `HikvisionSdkFacade` 和协议 URI 配置中；取得报文后无需改动 MQTT 主流程和路由框架。

## 启动

```bash
cd deploy
cp .env.example .env
# 修改 .env 和 application.yml，并将海康 Linux x86_64 SDK 放入 hikvision-sdk/
docker compose up -d --build
```

健康检查：`GET http://服务器:8080/actuator/health`

## MQTT 指令示例

```json
{
  "requestId": "202607140001",
  "deviceId": "SW001",
  "vendor": "AODUN",
  "command": "LED_TEXT_SET",
  "timestamp": 1784000000000,
  "expireAt": 1784000060000,
  "params": {"text": "森林防火，人人有责", "duration": 15}
}
```

## 支持命令

`LED_TEXT_SET`、`LED_SWITCH`、`VOICE_CONTENT_SET`、`VOICE_PLAY`、`VOICE_STOP`、`VOICE_VOLUME_SET`、`VOICE_SWITCH`、`LAMP_SWITCH`、`COMPONENT_CONTROL`、`DEVICE_STATUS_QUERY`。

## 构建

```bash
mvn clean test
mvn clean package
```
