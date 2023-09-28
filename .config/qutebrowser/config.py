import subprocess
import os
from qutebrowser.api import interceptor
import sys
import catppuccin

# Autogenerated config.py
#
# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Change the argument to True to still load
# settings configured via autoconfig.yml

config.load_autoconfig(True)

# block youtube adds
# def filter_yt(info: interceptor.Request):
#     """Block the given request if necessary."""
#     url = info.request_url
#     if (
#         url.host() == "www.youtube.com"
#         and url.path() == "/get_video_info"
#         and "&adformat=" in url.query()
#     ):
#         info.block()
#
#
# interceptor.register(filter_yt)
# #
# sys.path.append(os.path.join(sys.path[0], 'jblock'))
# config.source("jblock/jblock/integrations/qutebrowser.py")


def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)





# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "chrome-devtools://*")


# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "devtools://*")

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
    "https://accounts.google.com/*",
)

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36",
    "https://*.slack.com/*",
)


# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")

# picking fileselector
config.set("fileselect.handler", "external")
config.set(
    "fileselect.single_file.command",
    ["alacritty", "--class", "ranger,ranger", "-e", "ranger", "--choosefile", "{}"],
)
config.set(
    "fileselect.multiple_files.command",
    ["alacritty", "--class", "ranger,ranger", "-e", "ranger", "--choosefiles", "{}"],
)


# nord = {
#     # Polar Night
#     "nord0": "#2e3440",
#     "nord1": "#3b4252",
#     "nord2": "#434c5e",
#     "nord3": "#4c566a",
#     # Snow Storm
#     "nord4": "#d8dee9",
#     "nord5": "#e5e9f0",
#     "nord6": "#eceff4",
#     # Frost
#     "nord7": "#8fbcbb",
#     "nord8": "#88c0d0",
#     "nord9": "#81a1c1",
#     "nord10": "#5e81ac",
#     # Aurora
#     "nord11": "#bf616a",
#     "nord12": "#d08770",
#     "nord13": "#ebcb8b",
#     "nord14": "#a3be8c",
#     "nord15": "#b48ead",
# }
#
# ## Background color of the completion widget category headers.
# ## Type: QssColor
# c.colors.completion.category.bg = nord["nord0"]
#
# ## Bottom border color of the completion widget category headers.
# ## Type: QssColor
# c.colors.completion.category.border.bottom = nord["nord0"]
#
# ## Top border color of the completion widget category headers.
# ## Type: QssColor
# c.colors.completion.category.border.top = nord["nord0"]
#
# ## Foreground color of completion widget category headers.
# ## Type: QtColor
# c.colors.completion.category.fg = nord["nord5"]
#
# ## Background color of the completion widget for even rows.
# ## Type: QssColor
# c.colors.completion.even.bg = nord["nord1"]
#
# ## Background color of the completion widget for odd rows.
# ## Type: QssColor
# c.colors.completion.odd.bg = nord["nord1"]
#
# ## Text color of the completion widget.
# ## Type: QtColor
# c.colors.completion.fg = nord["nord4"]
#
# ## Background color of the selected completion item.
# ## Type: QssColor
# c.colors.completion.item.selected.bg = nord["nord3"]
#
# ## Bottom border color of the selected completion item.
# ## Type: QssColor
# c.colors.completion.item.selected.border.bottom = nord["nord3"]
#
# ## Top border color of the completion widget category headers.
# ## Type: QssColor
# c.colors.completion.item.selected.border.top = nord["nord3"]
#
# ## Foreground color of the selected completion item.
# ## Type: QtColor
# c.colors.completion.item.selected.fg = nord["nord6"]
#
# ## Foreground color of the matched text in the completion.
# ## Type: QssColor
# c.colors.completion.match.fg = nord["nord13"]
#
# ## Color of the scrollbar in completion view
# ## Type: QssColor
# c.colors.completion.scrollbar.bg = nord["nord1"]
#
# ## Color of the scrollbar handle in completion view.
# ## Type: QssColor
# c.colors.completion.scrollbar.fg = nord["nord5"]
#
# ## Background color for the download bar.
# ## Type: QssColor
# c.colors.downloads.bar.bg = nord["nord0"]
#
# ## Background color for downloads with errors.
# ## Type: QtColor
# c.colors.downloads.error.bg = nord["nord11"]
#
# ## Foreground color for downloads with errors.
# ## Type: QtColor
# c.colors.downloads.error.fg = nord["nord5"]
#
# ## Color gradient stop for download backgrounds.
# ## Type: QtColor
# c.colors.downloads.stop.bg = nord["nord15"]
#
# ## Color gradient interpolation system for download backgrounds.
# ## Type: ColorSystem
# ## Valid values:
# ##   - rgb: Interpolate in the RGB color system.
# ##   - hsv: Interpolate in the HSV color system.
# ##   - hsl: Interpolate in the HSL color system.
# ##   - none: Don't show a gradient.
# c.colors.downloads.system.bg = "none"
#
# ## Background color for hints. Note that you can use a `rgba(...)` value
# ## for transparency.
# ## Type: QssColor
# c.colors.hints.bg = nord["nord13"]
#
# ## Font color for hints.
# ## Type: QssColor
# c.colors.hints.fg = nord["nord0"]
#
# ## Font color for the matched part of hints.
# ## Type: QssColor
# c.colors.hints.match.fg = nord["nord10"]
#
# ## Background color of the keyhint widget.
# ## Type: QssColor
# c.colors.keyhint.bg = nord["nord1"]
#
# ## Text color for the keyhint widget.
# ## Type: QssColor
# c.colors.keyhint.fg = nord["nord5"]
#
# ## Highlight color for keys to complete the current keychain.
# ## Type: QssColor
# c.colors.keyhint.suffix.fg = nord["nord13"]
#
# ## Background color of an error message.
# ## Type: QssColor
# c.colors.messages.error.bg = nord["nord11"]
#
# ## Border color of an error message.
# ## Type: QssColor
# c.colors.messages.error.border = nord["nord11"]
#
# ## Foreground color of an error message.
# ## Type: QssColor
# c.colors.messages.error.fg = nord["nord5"]
#
# ## Background color of an info message.
# ## Type: QssColor
# c.colors.messages.info.bg = nord["nord8"]
#
# ## Border color of an info message.
# ## Type: QssColor
# c.colors.messages.info.border = nord["nord8"]
#
# ## Foreground color an info message.
# ## Type: QssColor
# c.colors.messages.info.fg = nord["nord5"]
#
# ## Background color of a warning message.
# ## Type: QssColor
# c.colors.messages.warning.bg = nord["nord12"]
#
# ## Border color of a warning message.
# ## Type: QssColor
# c.colors.messages.warning.border = nord["nord12"]
#
# ## Foreground color a warning message.
# ## Type: QssColor
# c.colors.messages.warning.fg = nord["nord5"]
#
# ## Background color for prompts.
# ## Type: QssColor
# c.colors.prompts.bg = nord["nord2"]
#
# # ## Border used around UI elements in prompts.
# # ## Type: String
# c.colors.prompts.border = "1px solid " + nord["nord0"]
#
# ## Foreground color for prompts.
# ## Type: QssColor
# c.colors.prompts.fg = nord["nord5"]
#
# ## Background color for the selected item in filename prompts.
# ## Type: QssColor
# c.colors.prompts.selected.bg = nord["nord3"]
#
# ## Background color of the statusbar in caret mode.
# ## Type: QssColor
# c.colors.statusbar.caret.bg = nord["nord15"]
#
# ## Foreground color of the statusbar in caret mode.
# ## Type: QssColor
# c.colors.statusbar.caret.fg = nord["nord5"]
#
# ## Background color of the statusbar in caret mode with a selection.
# ## Type: QssColor
# c.colors.statusbar.caret.selection.bg = nord["nord15"]
#
# ## Foreground color of the statusbar in caret mode with a selection.
# ## Type: QssColor
# c.colors.statusbar.caret.selection.fg = nord["nord5"]
#
# ## Background color of the statusbar in command mode.
# ## Type: QssColor
# c.colors.statusbar.command.bg = nord["nord2"]
#
# ## Foreground color of the statusbar in command mode.
# ## Type: QssColor
# c.colors.statusbar.command.fg = nord["nord5"]
#
# ## Background color of the statusbar in private browsing + command mode.
# ## Type: QssColor
# c.colors.statusbar.command.private.bg = nord["nord2"]
#
# ## Foreground color of the statusbar in private browsing + command mode.
# ## Type: QssColor
# c.colors.statusbar.command.private.fg = nord["nord5"]
#
# ## Background color of the statusbar in insert mode.
# ## Type: QssColor
# c.colors.statusbar.insert.bg = nord["nord14"]
#
# ## Foreground color of the statusbar in insert mode.
# ## Type: QssColor
# c.colors.statusbar.insert.fg = nord["nord1"]
#
# ## Background color of the statusbar.
# ## Type: QssColor
# c.colors.statusbar.normal.bg = nord["nord0"]
#
# ## Foreground color of the statusbar.
# ## Type: QssColor
# c.colors.statusbar.normal.fg = nord["nord5"]
#
# ## Background color of the statusbar in passthrough mode.
# ## Type: QssColor
# c.colors.statusbar.passthrough.bg = nord["nord10"]
#
# ## Foreground color of the statusbar in passthrough mode.
# ## Type: QssColor
# c.colors.statusbar.passthrough.fg = nord["nord5"]
#
# ## Background color of the statusbar in private browsing mode.
# ## Type: QssColor
# c.colors.statusbar.private.bg = nord["nord3"]
#
# ## Foreground color of the statusbar in private browsing mode.
# ## Type: QssColor
# c.colors.statusbar.private.fg = nord["nord5"]
#
# ## Background color of the progress bar.
# ## Type: QssColor
# c.colors.statusbar.progress.bg = nord["nord5"]
#
# ## Foreground color of the URL in the statusbar on error.
# ## Type: QssColor
# c.colors.statusbar.url.error.fg = nord["nord11"]
#
# ## Default foreground color of the URL in the statusbar.
# ## Type: QssColor
# c.colors.statusbar.url.fg = nord["nord5"]
#
# ## Foreground color of the URL in the statusbar for hovered links.
# ## Type: QssColor
# c.colors.statusbar.url.hover.fg = nord["nord8"]
#
# ## Foreground color of the URL in the statusbar on successful load
# ## (http).
# ## Type: QssColor
# c.colors.statusbar.url.success.http.fg = nord["nord5"]
#
# ## Foreground color of the URL in the statusbar on successful load
# ## (https).
# ## Type: QssColor
# c.colors.statusbar.url.success.https.fg = nord["nord14"]
#
# ## Foreground color of the URL in the statusbar when there's a warning.
# ## Type: QssColor
# c.colors.statusbar.url.warn.fg = nord["nord12"]
#
# ## Background color of the tab bar.
# ## Type: QtColor
# c.colors.tabs.bar.bg = nord["nord3"]
#
# ## Background color of unselected even tabs.
# ## Type: QtColor
# c.colors.tabs.even.bg = nord["nord3"]
#
# ## Foreground color of unselected even tabs.
# ## Type: QtColor
# c.colors.tabs.even.fg = nord["nord5"]
#
# ## Color for the tab indicator on errors.
# ## Type: QtColor
# c.colors.tabs.indicator.error = nord["nord11"]
#
# ## Color gradient start for the tab indicator.
# ## Type: QtColor
# # c.colors.tabs.indicator.start = nord['violet']
#
# ## Color gradient end for the tab indicator.
# ## Type: QtColor
# # c.colors.tabs.indicator.stop = nord['orange']
#
# ## Color gradient interpolation system for the tab indicator.
# ## Type: ColorSystem
# ## Valid values:
# ##   - rgb: Interpolate in the RGB color system.
# ##   - hsv: Interpolate in the HSV color system.
# ##   - hsl: Interpolate in the HSL color system.
# ##   - none: Don't show a gradient.
# c.colors.tabs.indicator.system = "none"
#
# ## Background color of unselected odd tabs.
# ## Type: QtColor
# c.colors.tabs.odd.bg = nord["nord3"]
#
# ## Foreground color of unselected odd tabs.
# ## Type: QtColor
# c.colors.tabs.odd.fg = nord["nord5"]
#
# # ## Background color of selected even tabs.
# # ## Type: QtColor
# c.colors.tabs.selected.even.bg = nord["nord0"]
#
# # ## Foreground color of selected even tabs.
# # ## Type: QtColor
# c.colors.tabs.selected.even.fg = nord["nord5"]
#
# # ## Background color of selected odd tabs.
# # ## Type: QtColor
# c.colors.tabs.selected.odd.bg = nord["nord0"]
#
# # ## Foreground color of selected odd tabs.
# # ## Type: QtColor
# c.colors.tabs.selected.odd.fg = nord["nord5"]
#
## Background color for webpages if unset (or empty to use the theme's
## color)
## Type: QtColor
# c.colors.webpage.bg = 'white'

catppuccin.setup(c, 'macchiato')
