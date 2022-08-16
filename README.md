# git-http-server
개인 깃 서버 구축을 위한 경량 도커 컨테이너입니다.

# Git 저장소 생성

1. 깃 레포지토리 생성
> git init --bare [레포지토리 명]

2. 레포지토리 접근
> cd [레포지토리 명]

3. 접근 권한 오픈
> git config http.receivepack true

4. 이메일 및 이름 설정
> git config --global user.email [이메일]
> git config --global user.name [이름]


# Git 보안 설정

1. nginx.conf 파일 내 auth_basic과 auth_basic_user_file  옵션 설정
```
http|location {
    ...
    auth_basic  "아무 문자열이나 넣어도 된다. ex) 접근 금지!"
    auth_basic_user_file [htpasswd 파일 경로]
}
```

2. htpasswd 파일을 생성 및 사용자를 추가한다.
파일 컨텐츠 형식은 한줄에 [아이디]:[md5 비밀번호]로 구성되어야 한다.
openssl 을 이용한 파일 내 아이디 추가 방법
> touch .htpasswd
> printf "[아이디]:$(openssl passwd -1 [비밀번호])\n" >> .htpasswd


# References
[ynohat/git-http-backend](https://github.com/ynohat/git-http-backend)
