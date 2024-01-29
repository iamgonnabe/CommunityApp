# flutterproject
\<Community App\>

## 📆 개발 기간

-  2024-12-29 ~ 2024-01-17

## 📌 개발 목적

- 앱 개발 경험을 쌓기 위함
- flutter 공부

## ⚒ Tools
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white) ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) 

## 🔎 주요 기능
1. 로그인
    - Firebase를 이용한 회원가입과 로그인 기능
2. 게시판
    - 글을 쓸 수 있는 게시판
    - 글에 댓글을 달 수 있는 기능
    - 글에 대댓글을 달 수 있는 기능
    - 좋아요가 많으면 HOT 게시판으로
    - 네이버 검색 API를 활용한 리뷰 게시판
 3. 채팅
    - 로그인한 유저끼리 채팅을 주고 받을 수 있는 기능
## ❤ 참고 자료
- [Nomad Coders 플러터 강의](https://nomadcoders.co/) 
- [Coding chef Youtube](https://www.youtube.com/@codingchef)   

## 🖥 Preview
<p float="left">
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/3b0e17f9-5a4c-491c-ac77-e5af630213a0/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/443cd125-5bca-48e3-a821-1d9812e12439/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/44b316cc-d5ef-452e-b16c-b402e9207c8e/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/a2a68c23-c2d0-4ede-879c-c29bd9a405b3/image.jpg" height="400" />
</p>
<p float="left">
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/61ebbcc0-a569-4a03-899c-442fc653c759/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/2adb2860-2685-4278-aff0-bdb012c2c891/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/81b7d567-fc23-44fc-b92f-09fffc40c385/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/a9d0881d-99a3-4e32-a3e9-5b4d7a37f838/image.jpg" height="400" />
</p>
<p float="left">
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/471259a4-b754-449e-846a-d78611d94110/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/62feb02d-d92b-4bc9-a320-235eb3759a16/image.jpg" height="400" />
  <img src="https://velog.velcdn.com/images/wjdwlsdl321/post/078f3cf2-de0f-4418-a954-a6368403e65a/image.jpg" height="400" />
</p>

## 후기 및 개선점
flutter를 공부한지 3일 후에 바로 프로젝트를 시작하다보니 state 관련해서 어려움을 겪었다.
개발 후반부에 들어서야 GetX와 Provider를 공부하여 도입하다 보니 state 관리가 매우매우 중요하다는 것을 깨달았다. 또한 Firebase를 다루는 것이 조금 힘들었다. 글을 firestore에 저장하고 또 글에  댓글을 저장하고 그 댓글에 대댓글을 저장하는 과정이 처음부터 설계를 하지 않고 개발하다 보니 생각보다 까다로웠다.

개선해야 할 점은 자유게시판에서 일정 좋아요 수를 넘기면 HOT게시판으로 복사가 되는데 복사해야 할게 글 뿐만 아니라 좋아요 state나 댓글, 대댓글까지 복사를 해야하지만 대댓글을 복사하는 기능은 구현하지 못했다. 댓글을 복사할 때 documnet id가 다르기 때문에 복사하는데 난항을 겪었다.

## Refactoring 2024-01-29
HOT게시판을 firestore에서 복사를 하는 방식이 아니라 자유게시판에서 likes가 0보다 크면 보일 수 있게 변경하여 보다 간단하게 코드를 구현시켰다. 댓글, 대댓글, 좋아요를 한 곳에서만 변경하면 되서 그 전에 게시판에 따라 if문을 넣어 난잡해진 코드를 refactoring 하였다.
