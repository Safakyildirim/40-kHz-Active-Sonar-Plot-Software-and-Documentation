#include <40khz.h>

void main()
{
	setup_timer_2(T2_DIV_BY_1,124,1);		//25,0 us overflow, 25,0 us interrupt

	setup_ccp1(CCP_PWM|CCP_SHUTDOWN_AC_L|CCP_SHUTDOWN_BD_L);
	set_pwm1_duty((int16)248);

	while(TRUE)
	{
		//TODO: User Code
	}

}
