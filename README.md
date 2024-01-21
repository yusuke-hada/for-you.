# for-you.
  
## サービス概要  
  
「for you.」は、プレゼント選びに悩む方に対して贈りたい相手の特徴を入力することで個々のユーザーの状況にあったプレゼント提案をAIが行います。また、プレゼントに合わせたメッセージカード作成やリマインダー機能で大切な日を忘れないように通知するなどプレゼントに特化したサービスです  
  
  
## 想定されるユーザー層  
  
プレゼント選びで何を贈るべきか悩んでいる方  
  
  
## サービスコンセプト  
  
誰しも一度はプレゼント選びをする際に悩んだことがあると思います。  
また誰に何を送ったのか時間が経つと忘れてしまったり、うっかり記念日を忘れてしまっていて直前になって急いでプレゼント選びをするなんていうこともあると思います。  
プレゼントを選ぼうとネットで検索すると"〇〇　プレゼント ランキング"のようなサイトがよく見受けられます。そのようなサイトを閲覧させてもらいましたがシーンや年代、関係性は選べるものの各サイトによってランキングの順位も違ったり、大まかなカテゴリーの順位(コスメ、アクセサリー、花など)であったりします。  
また私は男性なので特に女性にプレゼントを送る際にサプライズ性を持たせたい場面では何が欲しいのか聞けないことが多く苦慮した経験が沢山あります。  
なぜ悩んでしまうのか考えた結果、主な要素として  
・特に異性へのプレゼントの場合、相手の欲しいものを把握するのが難しい  
・送る相手の性別、年齢、関係性、好みなどによって、選ぶべきプレゼントが変わる  
・プレゼント商品(選択肢)が多すぎる  
があるのではないかと考えました。  
「for you.」はユーザーがプレゼントを贈りたい相手の情報を入力することでAIが分析し、プレゼントを提案してくれるサービスです。それ以外にもユーザーのほしい物リストを閲覧しプレゼント選びの参考にしてもらいたいと思います。メッセージカードの作成を行えるためプレゼントと一緒に贈ることができます。また誰に何を贈ったのかを登録することで今後その方へ贈るプレゼントの参考にしたり、リマインド機能で記念日などの設定した日付の数週間前から通知を送ることで当サービスを継続して利用していただけるようにしていきます。   
   
   
## 実装を予定している機能  
### MVP  
* 会員登録(入力する情報が多くなるのでステップ入力機能を実装)  
* ログイン/ログアウト  
* プロフィール編集  
* AIによるプレゼント提案  
* AIに情報を入力する際のオートコンプリート機能  
* メモ機能  
* AIが提案したものをAPIを通じて商品を表示する  
* メッセージカード作成
* メッセージカードをファイルで保存できる  
* ユーザーの欲しいものリスト一覧(各ユーザーのほしいものリストと名前以外の情報を紐付けて公開)  
* SNSシェア機能  
  
  
### その後の機能  
* リマインド機能(LINE通知)  
* ゲストログイン  
* admin機能  

## 画面遷移図  
  
https://www.figma.com/file/wGQAVxqDG41YjIRCg6FgwO/for-you.?type=design&node-id=0%3A1&mode=design&t=EIJCu57SXe1hTjma-1  
  
## ER図

https://drive.google.com/file/d/1nbAQVnMFHjkcMOdNGinTU28_iR_Jqhh4/view?usp=sharing  

![image](https://github.com/yusuke-hada/for-you./assets/128974750/3be59109-230a-4042-a280-db878e9162ca)  

