import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Test_Provider.dart';

class ConsumerTestPage extends StatelessWidget {
  const ConsumerTestPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        title: Text(title),
        centerTitle: true,
      ),
      body: Consumer<TestProvider>(
        builder: (context, provider, widget){
          if(provider.orderList.isEmpty){
            return SizedBox(
              height: MediaQuery.of(context).size.height -52,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: Text('장바구니 비어있음'),),
            );
          }else{
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(children: [
                    Checkbox(value: provider.allCheck, onChanged: (value) => provider.changeAllCheck()),
                    const Text('전체선택')
                  ],),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: provider.orderList.length,
                          (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(value: provider.checkList[index], onChanged: (value) => provider.changeCheck(index),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(provider.orderList[index].productName),
                              Text('${provider.orderList[index].price}원'),
                              Text('${provider.orderList[index].count}개')
                            ],
                          ),
                          IconButton(onPressed: ()=> provider.removeOrder(index), icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                    itemExtent: 100),
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    child: const Text('구매하기'),
                    onPressed: ()=> provider.pressBuyBtn(),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
