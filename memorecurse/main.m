//
//  main.m
//  memorecurse
//
//  Created by macbook on 2014/08/09.
//  Copyright (c) 2014年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

const int coinkind=6; // 硬貨の種類
const int imax=63; // 残額=最大支払い回数
const int minus=-1111; // 未計算に入るわかりやすい数字
const int inf=7777; // あり得ない大きい数字
int coinvalue[coinkind]={1,2,4,8,16,32}; // 各硬貨の額
int memo[imax]; // メモ化の本体
int hit=0; // 残額が0になった組合せ
int answer; // 返り値格納
int minnum=0;
int valuememo[imax];
int answermemo[imax];
int k,l,o; // テスト用

// 深さ優先探索+メモ化再帰、本体
int rec(int j,int m){
    if(m == 0){
        hit++;
        /* 使った硬貨の種類を出そうとしたが、うまくいかず
        if(minnum==0|minnum>j){
            minnum=j;
            for(int i=0;i<minnum;i++){
                answermemo[i]=valuememo[i];
            }
        }
        */
        return 0;}  // 再帰の終了条件
    
    if(memo[m-1] == minus){  // もし未計算だったら
        int result = inf; // 結果が返ってくれば上書きされる
        for(int i = 0; i < coinkind; i++){
            //valuememo[j]=coinvalue[i];
            if(m - coinvalue[i] >= 0){
                // 比較して小さい方をresultに返す。
                // 深さ優先探索のため、最下層から順にメモが作られる。同じ深さのfor0-5の
                // 中でresultは比較され、階層毎に一番小さい結果をresultとして書き換えている。
                // mがマイナスになる場合は冒頭のifで弾かれる。
                if (result > rec(j+1,m - coinvalue[i])+1){
                    k++,
                    result = rec(j+1,m - coinvalue[i])+1;
                } else {
                    l++;
                    result = result;
                }
            }
        }
        memo[m-1] = result;  // そしてメモ
    }
    o++;
    // 計算済みなら即座に memo[n] の値が返される
    return memo[m-1];
}

// メモ化再帰、前処理
int minChange(int n){
    // メモの初期化
    for (int i=0;i<n;i++){
        memo[i]=minus;
    }
    // メモ化再帰本体呼出+返り値
    return rec(0,n);
}


int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        answer=minChange(imax);
        // 出力
        
        for (int i=0;i<imax;i++){
            NSLog(@"memo%d:%d",i,memo[i]);
        }
        /*
        for (int i=0;i<minnum;i++){
            NSLog(@"%d",answermemo[i]);
        }
        */
        NSLog(@"HIT数:%d",hit);
        //NSLog(@"変数K %d,L %d,O %d",k,l,o);
        NSLog(@"最小支払い枚数は%d",answer);
    }
    return 0;
}

