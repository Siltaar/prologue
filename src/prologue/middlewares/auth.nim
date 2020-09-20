from ../auth/auth import basicAuth, VerifyHandler
from  ../core/context import HandlerAsync, Context
from ../core/middlewaresbase import switch

import asyncdispatch, strtabs


proc basicAuthMiddleware*(realm: string, verifyHandler: VerifyHandler,
    charset = "UTF-8"): HandlerAsync =
  result = proc(ctx: Context) {.async.} =
    let (hasValue, username, password) = basicAuth(ctx, realm,
        verifyHandler, charset)
    if not hasValue:
      return
    ctx.ctxData["basic_username"] = username
    ctx.ctxData["basic_password"] = password
    await switch(ctx)