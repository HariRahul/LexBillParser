%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int sum = 0, curr_qty, f = 0, i = 0;
char cur_item[25];
char* items[25] = {"Schezwan Fried Rice","Chicken Noodles","Dosa","Idly"};
int price[] ={12, 100, 110, 35, 10};
%}

%%
"end" 					{
							printf("%d",sum);return 1;
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
