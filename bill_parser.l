%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int sum = 0, curr_qty, f = 0, i = 0, ind = 0;
char cur_item[25];
char* items[25] = {"Schezwan Fried Rice","Chicken Noodles","Dosa","Idly"};
int price[] ={12, 100, 110, 35, 10};
char *bill_items[25];
int bill_qty[30], bill_price[30];
%}

%%
"end" 					{
							printf("====================BILL=====================\n");
							for(i = 0; i < ind; i++){
								printf("%s %d %d\n", bill_items[i], bill_qty[i], bill_price[i]);
							}
							printf("TOTAL %d\n", sum);
							printf("====================END======================\n");
							return 1;
						}
([a-zA-Z])*				{	
							strcat(cur_item,yytext);
						}
(" ")* 					{
							strcat(cur_item,yytext);
						}
([*-+=!@#$%^()?/_])* 	{
							continue;
						} 
([0-9])*    		    {
							curr_qty=atoi(yytext);
						}
	"\n" 				{
							for(i = 0;i < sizeof(items)/sizeof(items[0]); i++){
								if(strcmp(items[i],cur_item) == 0){
									f = 1;
									sum += (price[i] * curr_qty);
									bill_items[ind] = cur_item;
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
%%

int yywrap(void){}

int main()
{
	yylex();
	return 0;
}
