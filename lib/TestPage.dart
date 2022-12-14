import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Test_Provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  //프로바이더 선언시 context가 필요하므로 나중에 넣어주기
  late TestProvider testProvider;

  @override
  Widget build(BuildContext context) {
    testProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: CustomScrollView(
          slivers: [
            //비어있니?
            testProvider.orderList.isEmpty ?
                const SliverToBoxAdapter() : SliverToBoxAdapter(
             child: Row(children: [
               Checkbox(value: testProvider.allCheck, onChanged: (value) => testProvider.changeAllCheck()),
               const Text('전체선택')
             ],),
            ),
            testProvider.orderList.isEmpty ?
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 52,
                    width: MediaQuery.of(context).size.width - 52,
                    child: const Center(child: Text('장바구니 비어있음'),),
                  ),
                ) :
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: testProvider.orderList.length,
                      (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(value: testProvider.checkList[index], onChanged: (value) => testProvider.changeCheck(index),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(testProvider.orderList[index].productName),
                              Text('${testProvider.orderList[index].price}원'),
                              Text('${testProvider.orderList[index].count}개')
                            ],
                          ),
                          IconButton(onPressed: ()=> testProvider.removeOrder(index), icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                    itemExtent: 100),
            testProvider.orderList.isEmpty ?
                const SliverToBoxAdapter() : SliverToBoxAdapter(
              child: ElevatedButton(
                child: const Text('구매하기'),
                onPressed: ()=> testProvider.pressBuyBtn(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
