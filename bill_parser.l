%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
int sum = 0, curr_qty, f = 0, i = 0, ind = 0, f1 = 0;
char cur_item[25];
char* items[25] = {"schezwan fried rice", "chicken noodles", "dosa", "idly", "omelette", "tea", "coffee", "milk", "gobi65"};
int price[] ={100, 110, 35, 10, 15, 12, 15, 10, 80};
char *bill_items[25];
int bill_qty[30], bill_price[30];
%}

%%
"\n"                            {
                                                        if(f1 == 0){
                                                        char *temp;
                                                        for(i = 0; i < cur_item[i]; i++){
                                                                cur_item[i] = tolower(cur_item[i]);
                                                        }
                                                        for(i = 0;i < sizeof(items)/sizeof(items[0]); i++){
                                                                if(strcmp(items[i],cur_item) == 0){
                                                                        f = 1;
                                                                        bill_items[ind] = "";
                                                                        sum += (price[i] * curr_qty);
                                                                        bill_items[ind] = items[i];
                                                                        bill_qty[ind] = curr_qty;
                                                                        bill_price[ind] = (price[i] * curr_qty);
                                                                        ind++;
                                                                        break;
                                                                }
                                                        }
                                                        if(f == 1){
                                                                printf("Item added\n");
                                                        }else{
                                                                printf("Item not available\n");
                                                        }
                                                        f=0;
                                                        strcpy(cur_item,"");
                                                        }
                                                        if(f1 == 2){
                                                                int rem = curr_qty - sum;
                                                                if(rem != 0){
                                                                        printf("Change to be returned %d\n", rem);
                                                                }else{
                                                                        printf("Bill settled!!!\n");
                                                                }
                                                                return 1;
                                                        }
                                                }
"end"                                   {
                                                        printf("====================BILL=====================\n");
                                                        printf("ITEM NAME\tQTY\tPRICE\n");
                                                        for(i = 0; i < ind; i++){
                                                                printf("%s\t\t%d\t%d\n", bill_items[i], bill_qty[i], bill_price[i]);
                                                        }
                                                        printf("TOTAL\t\t\t%d\n", sum);
                                                        printf("====================END======================\n");
                                                        printf("Enter the amount paid");
                                                        f1 = 1;
                                                }
([0-9])*                                {
                                                        curr_qty=atoi(yytext);
                                                        if(f1 == 1)
                                                                f1 = 2;
                                                }
([a-zA-Z0-9])*                          {
                                                        strcat(cur_item,yytext);
                                                }
(" ")*                                  {
                                                        strcat(cur_item,yytext);
                                                }
([*-+=!@#$%^()?/_])*                    {
                                                        continue;
                                                }
%%

int yywrap(void){}

int main()
{
        yylex();
        return 0;
}
