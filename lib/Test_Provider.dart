import 'package:flutter/material.dart';
import 'package:untitled/Order.dart';

class TestProvider with ChangeNotifier{
  List<Order> orderList = [
    Order(price: 1000, productName: '테스트아이템1', count: 1),
    Order(price: 2000, productName: '테스트아이템2', count: 2),
    Order(price: 3000, productName: '테스트아이템3', count: 3),
    Order(price: 4000, productName: '테스트아이템4', count: 4),
  ]; //주문리스트
  List<bool> checkList = [
    true, true,true,true
  ]; //주문리스트의 부분선택리스트
  bool allCheck = true; //전체선택

  void addOrder(Order order){
    orderList.add(order); //장바구니 버튼을 누르면 오더리스트에 하나 넣기
    checkList.add(true); //orderList 길이만큼 체크리스트도 필요함.
    notifyListeners(); //상태 업데이트
  }

  void removeOrder(int index){
    orderList.removeAt(index); //장바구니에서 삭제 버튼 누르면 해당 인덱스로 접근하여 삭제
    checkList.removeAt(index); //체크리스트도 해당 인덱스 제거
    notifyListeners(); //업데이트
  }

  void changeCheck(int index){
    //체크박스누를 때 실행되는 함수 체크되있으면 해제, 해제되있으면 체크되게 조건문
    checkList[index] ? checkList[index] = false : checkList[index] = true;

    //전체선택 조건검사
    if(checkList.contains(false) && allCheck){
      //체크리스트에 false가있는데 전체 선택이 참인경우
      allCheck = false; //전체선택을 꺼줌
    }else if(checkList.every((element) => element == true) && !allCheck){
      //체크리스트가 전부 true인데 전체선택이 꺼진경우
      allCheck = true; //전체선택 켜기
    }
    notifyListeners();//업데이트
  }

  void changeAllCheck(){
    //전체선택을 눌렀을 때
    if(allCheck){
      allCheck = false;
      //체크리스트 아이템들을 전부 false로 바꾼후 checkList에 넣기
      checkList = checkList.map((e) => e = false).toList();
    }else{
      allCheck = true;
      checkList = checkList.map((e) => e =  true).toList();
    }
    notifyListeners(); //업데이트
  }

  void pressBuyBtn(){
    List<Order> buyList = []; //최종구매리스트
    //최종 구매하기 버튼 클릭시, 체크되어있는 부분만 확인하기
    for(var i = 0; i<checkList.length; i++){
      //체크리스트 인덱스 중 참인경우에만 최종구매리스트에 넣어줌
      if(checkList[i]){
        buyList.add(orderList[i]);
      }
    }
  }
}