//
//  TimeTable.m
//  iPlan
//
//  Created by Yingbo Zhan on 11-6-18.
//  Copyright 2011 NUS. All rights reserved.
//




#import "TimeTable.h"
@interface TimeTable()
-(BOOL)checkPossibilityWithCurrentProgress:(NSMutableArray*)currentProgress
			WithAddInClassGroupInformation:(NSMutableArray*)AddInClassGroupInformation
							 WithTimeTable:(NSMutableArray*)timeTable
					  WithBasicInformation:(NSMutableArray*)basicInformation;
-(NSMutableArray*)nextToAddInToBasedOn:(NSMutableArray*)addInClassGroupInformation 
				   AndBasicInformation:(NSMutableArray*)basicInformation
					   WithModuleIndex:(NSMutableArray*)moduleIndex;
-(BOOL)checkCurrentWithAddInClassGroup:(NSMutableArray*)AddInClassGroupInformation
				  WithCurrentTimetable:(NSMutableArray*)timeTable;
-(BOOL)checkFutureWithAddInClassGroup:(NSMutableArray*)AddInClassGroupInformation
				 WithCurrentTimetable:(NSMutableArray*)timeTable
				  WithCurrentProgress:(NSMutableArray*)currentProgress
				 WithBasicInformation:(NSMutableArray*)basicInformation;
-(void)addSlot:(NSMutableArray*)addInClassGroupInformation
 WithTimeTable:(NSMutableArray*)timeTable;
-(void)deleteSlot:(NSMutableArray*)AddInClassGroupInformation
	WithTimeTable:(NSMutableArray*)timeTable;
-(NSMutableArray*)constructInitialCurrentProgress;
-(NSMutableArray*)constructBasicInformation;
-(NSMutableArray*)constructInitialTimeTable;
-(NSMutableArray*)constructResult;
-(NSMutableArray*)constructModuleIndex;
-(BOOL)checkConflictSlot:(Slot*)slot WithCurrentTimetable:(NSMutableArray*)timeTable;
@end

@implementation TimeTable
@synthesize name;
@synthesize modules;

-(id)initWithName:(NSString*)naming
{
	[super init];
	if(super !=nil)
	{
		name = naming;
		modules = [[NSMutableArray alloc]init];
	}
	return self; 
}

-(id)initWithName:(NSString*)naming WithModules:(NSMutableArray*)module
{
	[super init];
	if(super !=nil)
	{
		name = naming;
		modules = module;
	}
	return self;
}


-(BOOL)getOneDefaultSolutionsWithCurrentProgress:(NSMutableArray*)currentProgress
							WithBasicInformation:(NSMutableArray*)basicInformation
						WithAddInClassGroupInformation:(NSMutableArray*)addInClassGroup
								   WithTimeTable:(NSMutableArray*)timeTable
									  WithResult:(NSMutableArray*)result
								 WithModuleIndex:(NSMutableArray*)moduleIndex
{
	
	if([self checkPossibilityWithCurrentProgress:currentProgress
				  WithAddInClassGroupInformation:addInClassGroup
								   WithTimeTable:timeTable
							WithBasicInformation:basicInformation])
	{
		//find next
		NSMutableArray* newAddInClassGroupInformation = [self nextToAddInToBasedOn:addInClassGroup
															   AndBasicInformation:basicInformation
																   WithModuleIndex:moduleIndex];
		if([newAddInClassGroupInformation count]==0)
			return YES;
		else 
		{
			//updateBasedOn
			NSMutableArray* newCurrentProgress = [[NSMutableArray alloc]init];
			NSMutableArray* newTimeTable = [[NSMutableArray alloc]init];
			NSMutableArray* newResult = [[NSMutableArray alloc]init];
			
			[result release];
			[currentProgress release];
			[timeTable release];
			[addInClassGroup release];
			return [self getOneDefaultSolutionsWithCurrentProgress:newCurrentProgress
											  WithBasicInformation:basicInformation
									WithAddInClassGroupInformation:newAddInClassGroupInformation
													 WithTimeTable:newTimeTable
														WithResult:newResult
												   WithModuleIndex:moduleIndex];
	
		}
	}
	else 
	{
		return NO;
	}

	//currentProgress is an array of current module information
	//it is an array of array
	//for each active module, 
	//0.module index in orginal modules list
	//1.current module classtype index
	//2.current ClassGroup index
	
	//basic information is an array of array of array
	//for each active module correspond to the modules in current progress
	//for each classtype
	//the maximum number of ClassGroup
	
	
	//AddInClassGroup
	//similar to currentprogess
	//but it is a one level array
	
	
	//timeTable
	//Array of array
	//outer array defines the 7 days
	//inner array defines the 24 hours
	
	return NO;
	
}

-(NSMutableArray*)nextToAddInToBasedOn:(NSMutableArray*)addInClassGroupInformation 
				   AndBasicInformation:(NSMutableArray*)basicInformation
					   WithModuleIndex:(NSMutableArray*)moduleIndex
{
	NSMutableArray* newAddInClassGroupInformation = [[NSMutableArray alloc]init];
	int i;
	for(i=0;i<[moduleIndex count];i++)
	{
		if([[moduleIndex objectAtIndex:i] isEqual:[addInClassGroupInformation objectAtIndex:0]])//same module
		{
			NSMutableArray* information = [basicInformation objectAtIndex:i];
			NSNumber* totalGroupNumeber = [information objectAtIndex:[[addInClassGroupInformation objectAtIndex:1]intValue]];
			NSNumber* classtypeindex = [addInClassGroupInformation objectAtIndex:1];

			if(totalGroupNumeber-1 == [addInClassGroupInformation objectAtIndex:2])
			{
			    int totolClassTypes = [basicInformation count];
				if([[NSNumber numberWithInt: totolClassTypes-1]isEqualToNumber:classtypeindex])
				{
					if(i==[moduleIndex count]-1) //nothing to add
					{
						return newAddInClassGroupInformation;
					}
					else
					{
						[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:i+1]];
						[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:0]];
						[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:0]];
					}
				}
				else 
				{
					[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:i]];
					[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:[classtypeindex intValue]+1]];
					[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:0]];
				}
			}
			else 
			{
				[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:i]];
				[newAddInClassGroupInformation addObject:classtypeindex];
				//[newAddInClassGroupInformation addObject:[NSNumber numberWithInt:[addInClassGroupInformation objectAtIndex:2]+1]];
			}


						
		}
		else {
			continue;
		}

	}
	return newAddInClassGroupInformation;
}
-(BOOL)checkPossibilityWithCurrentProgress:(NSMutableArray*)currentProgress
				  WithAddInClassGroupInformation:(NSMutableArray*)addInClassGroupInformation
							 WithTimeTable:(NSMutableArray*)timeTable
					  WithBasicInformation:(NSMutableArray*)basicInformation
{
	
	
	if([self checkCurrentWithAddInClassGroup:addInClassGroupInformation WithCurrentTimetable:timeTable]||
	   [self checkFutureWithAddInClassGroup:addInClassGroupInformation WithCurrentTimetable:timeTable WithCurrentProgress:currentProgress WithBasicInformation:basicInformation] )
	{
		return NO;
	}

		//decide next addinclassgroup
		//new slot loop
		//recursion line
	
	else 
	{
		return YES;
	}


		
}
//if there is confliction return YES
//else return NO
-(BOOL)checkCurrentWithAddInClassGroup:(NSMutableArray*)addInClassGroupInformation
				  WithCurrentTimetable:(NSMutableArray*)timeTable
{
	int i,j;
	Module* module = [modules objectAtIndex:[[addInClassGroupInformation objectAtIndex:0]intValue]];
	ModuleClassType* classtypes = [[module moduleClassTypes]objectAtIndex:[[addInClassGroupInformation objectAtIndex:1]intValue]];
	ClassGroup* addInClassGroup = [[classtypes classGroups]objectAtIndex:[[addInClassGroupInformation objectAtIndex:2]intValue]];
	for (i=0; i<7; i++) 
	{
		for (j=0; j<24; j++) 
		{
			for (Slot* slot in [addInClassGroup slots]) 
			{
				BOOL conflict = NO;
				//check time conflict with timetable
				
				if(conflict)
					return NO; //contradict with timetable
			}
		}
	}
	return YES;
}
//if there is confliction return YES
//else return NO
-(BOOL)checkFutureWithAddInClassGroup:(NSMutableArray*)addInClassGroupInformation
				 WithCurrentTimetable:(NSMutableArray*)timeTable
				  WithCurrentProgress:(NSMutableArray*)currentProgress
				 WithBasicInformation:(NSMutableArray*)basicInformation
{
	[self addSlot:addInClassGroupInformation WithTimeTable:timeTable];
	int i,j;
	for(i=0;i<[currentProgress count];i++)
	{
		Module* module = [modules objectAtIndex:[[[currentProgress objectAtIndex:i]objectAtIndex:0]intValue] ];
		for(j=[[[currentProgress objectAtIndex:i]objectAtIndex:1]intValue]+1;j<[[basicInformation objectAtIndex:i]count];j++)//j represents classtype
		{
			
			NSArray* classtypes = [module moduleClassTypes];
			NSArray* classgroups = [[classtypes objectAtIndex:j]classGroups];
			BOOL conflict = YES;
			for(ClassGroup* classgroup in classgroups)
			{
				BOOL putInConflict = NO;
			
				for (Slot* slot in [classgroup slots]) 
				{
					putInConflict = putInConflict || [self checkConflictSlot:slot WithCurrentTimetable:timeTable];//if conflict return YES;
				}
				
				if(!putInConflict)
				{
					conflict = NO;
					break;
				}
				
			}
			if(conflict)
				return YES;
			
		}
	}
	return NO;
}

-(BOOL)checkConflictSlot:(Slot*)slot WithCurrentTimetable:(NSMutableArray*)timeTable
{
	return NO;
}
-(void)addSlot:(NSMutableArray*)addInClassGroupInformation
	WithTimeTable:(NSMutableArray*)timeTable
{
}

-(void)deleteSlot:(NSMutableArray*)AddInClassGroupInformation
	WithTimeTable:(NSMutableArray*)timeTable
{	
}

-(NSMutableArray*)constructInitialCurrentProgress
{
	NSMutableArray* currentProgress = [[NSMutableArray alloc]init];
	int i = 0;
	for(i=0;i<[modules count];i++)
	{
		if([[modules objectAtIndex:i] checkSelected])
		{
			NSMutableArray* information = [[NSMutableArray alloc]init];
			[information addObject:[NSNumber numberWithInt:i]];
			[information addObject:[NSNumber numberWithInt:-1]];//last success class type
			[information addObject:[NSNumber numberWithInt:-1]];//last success ClassGroup 
			[currentProgress addObject:information];
		}
	}
	return currentProgress;

}

									   
-(NSMutableArray*)constructBasicInformation
{
	NSMutableArray* basicInformation = [[NSMutableArray alloc]init];
	int i = 0;
	for(i=0;i<[modules count];i++)
	{
		if([[modules objectAtIndex:i] checkSelected])
		{
			NSMutableArray* information = [[NSMutableArray alloc]init];
			int j = 0;
			for(j=0;j<[[[modules objectAtIndex:i]moduleClassTypes]count];j++)
			{
				int numOfClassGroups = [[[[[modules objectAtIndex:i]moduleClassTypes] objectAtIndex:j]classGroups]count];
				[information addObject:[NSNumber numberWithInt:numOfClassGroups]];
			}
			[basicInformation addObject:information];
		}
	}
	return basicInformation;
}

-(NSMutableArray*)constructInitialTimeTable
{
	NSNumber *CommitToNo = [NSNumber numberWithInt:0];
	NSMutableArray* time = [[NSMutableArray alloc]init];
	int i = 0;
	for(i=0;i<7;i++)
	{
		NSMutableArray* day = [[NSMutableArray alloc]init];
		int j = 0;
		for(j=0;j<24;j++)
		{
			[day addObject:CommitToNo];
		}
		[time addObject:day];
	}
	return time;
}

-(NSMutableArray*)constructResult
{
	NSMutableArray* result = [[NSMutableArray alloc]init];
	int i = 0;
	for(i=0;i<[modules count];i++)
	{
		if([[modules objectAtIndex:i] checkSelected])
		{
			NSMutableArray* information = [[NSMutableArray alloc]init];
			int j = 0;
			for(j=0;j<[[[modules objectAtIndex:i]moduleClassTypes]count];j++)
			{
				NSNumber *CommitToNo = [NSNumber numberWithInt:-1];
				[information addObject:CommitToNo];
			}
			[result addObject:information];
		}
	}
	return result;
}
	
									   
									   
-(NSMutableArray*)constructModuleIndex
{
	NSMutableArray* moduleIndex = [[NSMutableArray alloc]init];
	int i = 0;
	for(i=0;i<[modules count];i++)
	{
		if([[modules objectAtIndex:i] checkSelected])
		{
			
			[moduleIndex addObject:[NSNumber numberWithInt:i]];
		}
	}
	return moduleIndex;
	
}	

									   
-(void)encodeWithCoder:(NSCoder *)coder
{
	
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:modules forKey:@"modules"];

}

-(id)initWithCoder:(NSCoder *)decoder
{
	if([super init]!=nil){
		[self initWithName:[decoder decodeObjectForKey:@"name"] WithModules:[decoder decodeObjectForKey:@"modules"]];
	}
	return self;
}

-(void)dealloc{
	[name release];
	[modules release];
	[super dealloc];
}



@end
