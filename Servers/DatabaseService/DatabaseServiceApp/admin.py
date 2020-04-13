from django.contrib import admin

"""
from .models import Choice, Question, User, List_Of_Users

class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['question_text']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
    ]
    inlines = [ChoiceInline]
    list_display = ('question_text', 'pub_date', 'was_published_recently')
    list_filter = ['pub_date']
    search_fields = ['question_text']
    
    admin.site.register(Question, QuestionAdmin)
"""

from .models import *


class ChoiceInline(admin.TabularInline):
    model = Question
    extra = 3


class ChoiceInlineTwo(admin.TabularInline):
    model = GameUserMap
    extra = 3


class UserAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Identifiers', {'fields': ['campus_id', ]}),
        ('Personal info', {'fields': ['first_name', 'last_name', ]}),
        ('Contact info', {'fields': ['email', ]}),
        ('Misc', {'fields': ['study_programme', ]}),
    ]
    list_display = ('id', 'campus_id', 'first_name', 'last_name', 'email', 'study_programme')
    list_filter = ['study_programme']
    search_fields = ['campus_id', 'first_name', 'last_name', 'email', 'study_programme']


class GameAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Game', {'fields': ['game_match_name', 'question_duration',  ]}),
        ('Personal info', {'fields': ['first_name', 'last_name', ]}),
        ('Contact info', {'fields': ['email', ]}),
        ('Misc', {'fields': ['study_programme', ]}),
    ]
    inlines = [ChoiceInline, ChoiceInlineTwo]
    list_display = ('id', 'campus_id', 'first_name', 'last_name', 'email', 'study_programme')
    list_filter = ['study_programme']
    search_fields = ['campus_id', 'first_name', 'last_name', 'email', 'study_programme']

    question_set_id = models.ForeignKey(QuestionSet, on_delete=models.CASCADE, to_field='id')
    game_users_id = models.ForeignKey(GameUserMap, on_delete=models.CASCADE, to_field='id')


admin.site.register(Player, UserAdmin)
admin.site.register(GameHistory)
admin.site.register(GameUserStatus)
admin.site.register(GameUserMap)
admin.site.register(Answer)
admin.site.register(Question)
admin.site.register(QuestionAnswers)
admin.site.register(QuestionSet)
admin.site.register(Game)
admin.site.register(InviteGameParam)
admin.site.register(Invite)
