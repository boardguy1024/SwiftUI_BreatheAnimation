# SwiftUI_BreatheAnimation
### SwiftUIでBreathe Animationの実装が直感的で簡単？だったので感動しました。

Startボタンをタップしたら3秒ごとに複数の丸が45度半時計周りで拡散しては、真ん中に集まるアニメーションです。
Timerを 0.1秒ごとにpublishしてその中で 3秒ごとにstartAnimating.toggleすることで丸が'拡散'<->'縮小'を繰り返す仕組みです。

動画の参考はこちら
https://www.youtube.com/watch?v=ZsE6YeNvhx0

![gif](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExODkzMmIzMmQ1Y2U0ZWEyZDlkNmJiNGY4ZTU5YjhiNGU1YmZmMDRmNSZjdD1n/cXiCr7SfBF6sjroFxu/giphy.gif)
