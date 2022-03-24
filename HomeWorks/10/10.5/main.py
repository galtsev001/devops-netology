import sentry_sdk
sentry_sdk.init(
    "https://bcefbf0294fe4ff7b1a14f09e1ed9d02@o1176627.ingest.sentry.io/6274613",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0,
    enviroment="developer",
    realese="myapp@1.0.0"
)

if __name__ == "main" :
    devizion_by_zero = 1/0