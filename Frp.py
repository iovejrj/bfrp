from loguru import logger

logger.add("{time}.log", rotation="500MB", encoding="utf-8", enqueue=True, compression="zip", retention="10 days")
