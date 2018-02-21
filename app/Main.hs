import System.Environment (getArgs)
import System.Process (callProcess)

sendNotification :: String -> IO ()
sendNotification = callProcess "notify-send" . pure

muteIt :: String -> IO ()
muteIt "y" = callProcess "pactl" ["set-sink-mute", "0", "1"]
             >> sendNotification "I R Quiet!"
muteIt "n" = callProcess "pactl" ["set-sink-mute", "0", "0"]
             >> sendNotification "Let there be sound!"

main :: IO ()
main = getArgs >>= (muteIt . head)
