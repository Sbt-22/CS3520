/*=======Assignment 1========
Author; Seabata Moshate
Programming language; C
E-mail;Sbtmoshate2296@gmail.com
Call or WhatsApp; +266 63075045
*/

#include <stdio.h>

//Function that reverses the prime number
int reverse(int num)
{
	int remainder, reverse = 0;
	while(num!=0)
	{
		remainder = num%10;
		reverse = reverse*10 + remainder;
		num=num/10;
	}
	return reverse;
}

//fn that finds prime numbers
int isPrime(int num)
{
	int isPrime= 1;
	
	int i = 2;
	while (i<=(num)/2)//divies the number with numbers from 2 to half of the number to get the remainder
	{
		if(num%i == 0)//if we get a remainder as 0 for any of those dividends, then num is not a prime
		{
			isPrime= 0;
			break;
		}
		i++;
	}
	return isPrime;
}
//function that checks whether the num is a palindrome
int not_palindrome(int num)
{
	int isPalindrome= 1;
	if(reverse(num)==num)
	{
		isPalindrome= 0;
	}
	return isPalindrome;
}

int isPrimeSq(int num)
{
	int i=1;
    while( i * i <= num)
    {
        if((num % i == 0) && (num / i == i))
        {
            return 1;
        }
        i++;
    }
    return 0;
}

int square_root(int num)
{
	int i=0;
	while (i*i < num)
	{
		i++;
	}
	return i;
}

int main()
{
	int i=0, num,rootNum,r,rootReverse;
	
	num=10;
	while (num>=10)
	{
		
		r = reverse(num);

        if(isPrimeSq(num) == 1 && isPrimeSq(r) == 1)
        {
            rootNum = square_root(num);
            rootReverse = square_root(r);

            if(isPrime(rootNum) == 1 && isPrime(rootReverse))
            {
                if(not_palindrome(num))
                {
                    printf("%d \n",num);
                    i++;
                    if(i==10)
                    {
                    	break;
					}
                }

            }
        }
        num++;
			
	}

	
	return 0;
}
