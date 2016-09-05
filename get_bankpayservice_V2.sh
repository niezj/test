#!/bin/bash
#
#Ip_list='10.1.112.71 10.1.112.72 10.1.112.161 10.1.112.162 10.1.112.163'
Ip_list='10.1.112.71'
Now_date=".`date +%F`"
Save_path=/tmp/logs/bankpayservice${Now_date}
Log_path=/opt/payment/logs/bankpayservice

#获取所需日志时间的函数
Get_date() {
    read -p "Enter year:"  Year
    #判断年份格式是否正确	
    while : ;do
	if [ -n  $Year ];then
	    break	
        elif [ $Year -ge 2014 -a $Year -le 9999 ];then
            break
        else
            echo -ne  "\033[31mWrong format! valid values is 2014-9999.\033[0mInput again:"
	    read Year
        fi
    done
    read -p "Enter month:" Month
    #判断月份格式是否正确
    while : ;do
	if [ -n  $Month ];then
            break
        elif [ $Month -ge 1 -a $Month -le 12 ];then
            break
        else
            echo -ne "\033[31mWrong format! valid values is 01-12.\033[0mInput again:"
            read Month
        fi
    done
    read -p "Enter day:" Day
    #判断日期是否正确
    while : ;do
	if [ -n  $Day ];then
            break
        elif [ $Month -ge 1 -a $Month -le 31 ];then
            break
        else
            echo -ne "\033[31mWrong format! valid values is 01-31.\033[0mInput again:" 
            read Day
        fi
    done
    #给目标日期赋值
    Target_date=.${Year}-${Month}-${Day}
    if [ $Target_date == $Now_date -o $Target_date == '.--' ];then
        Target_date=''
    fi
}

#获取日志和创建相应目录的函数
Get_log() {
    for IP in $Ip_list;do
    	if [ ! -d $Save_path ];then
            mkdir -p $Save_path/$IP
        fi
        scp $IP:$File_name  $Save_path/$IP 	
    done
}

#选择所需日志的名称和时间
echo -e "\033[32mabc base boc bocom ccb ceb Chinapay CIB CIBCar CMB icbc PSBC Unionpay Yeepay\033[0m"
read -p "Which target is you want:" Bank
while : ;do
    case $Bank in
    #abc相关项
    abc)
        echo -e "\033[32mb2b  b2c  h2h  qc\033[0m" 
        read -p "Which target is you want:" Pay_way
        while : ;do
            case $Pay_way in
            b2b)
                echo -ne "\033[31mdirectory is empty at present!\033[0m Enter [q|Q] to quit or choose again:";
                read Pay_way;;
            b2c)
	        echo -e "\033[32mBC51 BC52 BC81 BC82 BC91 BC92\033[0m"
                read -p "Which target is you want:" Log_type
                while : ;do
                    case $Log_type in
                    BC51|BC52|BC81|BC82|BC91|BC92)
                        break;;
                    q|Q)
                        exit;;
                    *)
                        echo -ne "\033[31mWrong input!\033[0mEnter [q|Q] to quit or input again or choose again:"
                        read Log_type
                        continue;;
		    esac
                done
		break;;
            h2h)
                echo -e "\033[32mHH62 HH81 HH82 HH84 HH892 HH93\033[0m" 
		read -p "Which target is you want:" Log_type
                while : ;do
                    case $Log_type in
                    HH62|HH81|HH82|HH84|HH892|HH93)
                        break;;
                    q|Q)
                        exit;;
                    *)
                        echo -ne "\033[31mWrong input!\033[0mEnter [q|Q] to quit or choose again:"
                        read Log_type
                        continue;;
                    esac
                done
                break;;
            qc)
	        echo -e "\033[31mdirectory is empty at present!\033[0m Enter [q|Q] to quit or choose again:";
   	        read Pay_way;;
	    q|Q)
	        exit;;
            *)
	        echo -ne "\033[31mWrong input!\033[0mEnter [q|Q] to quit or choose again:"
                read Pay_way
                continue;;
            esac
        done
	Get_date
	File_name=${Log_path}/${Bank}/${Pay_way}/BankABC_${Log_type}.log${Target_date}
	Get_log
	echo -ne "\033[32mOkay! get log file done.Do you need any more?\033[0m[y|n]" 
        read Choice
        [ $Choice == y -o $Choice == Y ] && continue || break;;
    base)
	Get_date;;    
    q|Q)
        break;;		
    *)
	echo -ne "\033[31mWrong input!\033[0m Enter [q|Q] to quit or choose again:"
        read Bank;;
    esac
done





#case $Pay_way in
#b2c)
#    echo -e  "\033[31m\033[0m"
#qbc)
#    
#h2h)
#    
#esac
#
#Time=${Year}-${Month}-${Day}
#echo $Time
#
#
