import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/Tasks/presntation/ui/wedgit/task_option_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  String category = 'Personal';
  String deadline = 'Now';
  String priority = 'Medium';

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarWedgit(title: "Add Task",),
              25.verticalSpace,

        
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 20.sp,
                      color: AppColors.mainColor,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Let AI help you create the best plan',
                        style: AppTextstyle.hintTextStyle,
                      ),
                    ),
                  ],
                ),
              ),

            28.verticalSpace,

              Text(
                'What do you want to do ?',
                style: AppTextstyle.h2.copyWith(fontWeight: FontWeight.bold),
              ),
12.verticalSpace,

              TextformWedgit(
                controller: titleController,
                hintT: 'What do you want to do?',
                isPass: false,
              ),

             25.verticalSpace,

              Text(
                'Additional details ( optional )',
                   style: AppTextstyle.h2.copyWith(fontWeight: FontWeight.bold),
                
              ),
              
              14.verticalSpace,

             
              TaskOptionWidget(
                icon: Icons.category_outlined,
                title: 'Category',
                value: category,
                options: const [
                  'Study',
                  'Work',
                  'Personal',
                  'Health',
                  'Social',
                  'Admain',
                  'Other',
                ],
                onSelected: (value) {
                  setState(() {
                    category = value;
                  });
                },
                iconColor: AppColors.mainColor,
              ),

             12.verticalSpace,

              TaskOptionWidget(
                icon: Icons.calendar_today_outlined,
                title: 'Deadline',
                value: deadline,
                options: const [
                  'Today',
                  'Tomorrow',
                  'This Week',
                  'Next Week',
                ],
                onSelected: (value) {
                  setState(() {
                    deadline = value;
                  });
                },
                iconColor: AppColors.mainColor,
              ),

            12.verticalSpace,

             
              TaskOptionWidget(
                icon: Icons.flag_outlined,
                title: 'Priority / Urgency',
                value: priority,
                options: const [
                  'Low',
                  'Medium',
                  'High',
                ],
                onSelected: (value) {
                  setState(() {
                    priority = value;
                  });
                },
                iconColor: Colors.blue.shade50,
              ),

             18.verticalSpace,
TextformWedgit(
  controller: detailsController,
  hintT: 'Add more details about your task...',
  isPass: false,
 
),

             30.verticalSpace,
             MainbuttonWedgit(title:"Set Task",onTap: (){
              Navigator.pushNamed(context, AppRoutes.homeScreen);
             },),
             30.verticalSpace,
             Center(child: Text("Or",style: AppTextstyle.hint24,)),
          20.verticalSpace,
              MainbuttonWedgit(title: " ✨Create with Ai",),
              //onTap: (){
                //Navigator.push(context,processing Screen )
              //},
              
        
25.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}